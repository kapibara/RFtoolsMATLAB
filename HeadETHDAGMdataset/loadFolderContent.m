function data = loadFolderContent(person,verbose)
    p = '/home/kuznetso/tmp/kinect_head_pose_db/';
  
    imgDir = [p num2str(person,'%0.2u') '/'];

    depthFiles = dir([imgDir '*.bin']);
    
    gtDir = [p 'db_annotations/' num2str(person,'%0.2u') '/'];
    maskDir = [p 'head_pose_masks/' num2str(person,'%0.2u') '/'];
    
    ids = [];
    data = {};
    
    [P,k,Rel,s]=readCal([imgDir 'depth.cal']);
    cam = CCamera(P);
    
    l0 = -300;
    
    for i=1:length(depthFiles)
        imnumber = regexp(depthFiles(i).name,'_(\d{5})_','tokens');
        ids = [ids; str2double(imnumber{1}{1})];
        I = readBinImg([imgDir depthFiles(i).name]);
        [C,R] = readRC([imgDir 'frame_' imnumber{1}{1} '_pose.txt']);

        tmp.name = [imgDir depthFiles(i).name];
        if(exist([maskDir 'frame_' imnumber{1}{1} '_depth_mask.png'],'file'))
            tmp.mask = [maskDir 'frame_' imnumber{1}{1} '_depth_mask.png'];
        else
            tmp.mask = [];
        end
        tmp.number = ids(end);
        tmp.I = I;
        tmp.R = R;
        tmp.C = C;
        [tmp.C2D,tmp.D] = cam.PC2proj(C);
        if(exist([gtDir 'frame_' imnumber{1}{1} '_pose.bin'],'file'))
            tmp.gt = readGT([gtDir 'frame_' imnumber{1}{1} '_pose.bin']);
            gt = tmp.gt;
            pc = cam.proj2PC(I');
            proj1 = (pc - repmat(gt(1:3)',size(pc,1),1)) *R(:,1);
            proj2 = (pc - repmat(gt(1:3)',size(pc,1),1)) *R(:,2);
            dist = proj1.^2 + proj2.^2;
            [~, nosep] = min(dist);
            tmp.nose2D = cam.PC2proj(pc(nosep,:));  
            tmp.nose = pc(nosep,:);
        else
            tmp.gt = [];
            gt = tmp.gt;
        end


        
        data = [data; tmp];
        if(verbose && mod(i,10) == 0)
            xnew = gt(1:3) + l0*R(:,1);
            ynew = gt(1:3) + l0*R(:,2);
            znew = gt(1:3) + l0*R(:,3); %nose direction                 
            
            cla(gca);
            hold on
            plot3(pc(:,1),pc(:,2),pc(:,3),'+');
            plot3(gt(1),gt(2),gt(3),'or');
            plot3([gt(1) xnew(1)],[gt(2) xnew(2)],[gt(3) xnew(3)],'-r','LineWidth',3)
            plot3([gt(1) ynew(1)],[gt(2) ynew(2)],[gt(3) ynew(3)],'-g','LineWidth',3)
            plot3([gt(1) znew(1)],[gt(2) znew(2)],[gt(3) znew(3)],'-b','LineWidth',3)
            axis equal
            pause
        end
    end
    
    newdata = cell(max(ids),1);
    newdata(ids) = data;
    data = newdata;
end