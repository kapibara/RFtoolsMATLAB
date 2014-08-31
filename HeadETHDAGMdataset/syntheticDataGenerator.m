person = 1;

p = '/home/kuznetso/tmp/kinect_head_pose_db/';

subf = num2str(person,'%0.2u') ;

[V,F3,F4]=loadawobj([p subf '.obj']);

[P,k,Rel,s]=readCal([p subf '/depth.cal']);
cam = CCamera(P);
cam.intParams_([1 2],3) = cam.intParams_([2 1],3);

%load('gtproperties.mat','gt1_14');
data = loadFolderContent(person,0);

ecells = cellfun(@(x) isempty(x), data);
data(ecells) = [];
egt = cellfun(@(x) isempty(x.gt), data);
data(egt) = [];

gts = cell2mat(cellfun(@(x) x.gt', data, 'UniformOutput', false));

mingt = min(gts);
maxgt = max(gts);

outdir = '/home/kuznetso/tmp/HoughTests/Head_angles3D_synt/';

iter = 1;

maxIter = 1000;

fid = fopen([outdir 'files.txt'],'w');
fprintf(fid,repmat(',a',1,3));
fprintf(fid,'\n');

gtCR = rand(maxIter,6).*repmat((maxgt-mingt),maxIter,1) + repmat(mingt,maxIter,1);


while(iter<maxIter)

        R = GT2R(gtCR(iter,4:6));

        VR = R*V;

        VR = VR + repmat(gtCR(iter,1:3)',1,size(VR,2));

        [depth,mask] = cam.renderMesh(VR',F3');
        
        mask = double(mask);
        mask = mask/max(max(mask));
        
        outputfn = [outdir 'img' num2str(person) '_' num2str(iter) '.png'];
        
        depth = depth.*mask; 
              
        imwrite(uint16(depth),outputfn);
        
        fprintf(fid,outputfn);
        
        fprintf(fid,repmat(',%03.2f',1,3),gtCR(iter,4:6));
        
        fprintf(fid,'\n');
        
        iter = iter+1;
         
end

fclose(fid)

