

gt = [];

gc = -1;
grind = 5;
folder = '/home/kuznetso/tmp/HoughTests/Head_angles3D_test15_16/';

normalize = 0;
trainingset = 1;
persons = [15 16];
%persons = [11 12 13];

load('gt1_14.mat','gt1_14','sub1_14')


personsTr = [1:5 7:10];
gt1_14 = gt1_14(ismember(sub1_14, personsTr),:);


angles = [1 2 3];

p = 0.25; %percent of intersection

anglerange = [ min(gt1_14(:,grind))  max(gt1_14(:,grind))];
%non-intersecting anglerange
bounds = generateBounds(anglerange(1),anglerange(2),gc,p);

%collect gt for rescaling
%db: 1-14 one calib, 15-24 other calib
% for i=1:length(range)
%     data = loadFolderContent(range(i),0);
%     ecells = cellfun(@(x) isempty(x), data);
%     data(ecells) = [];
%     egt = cellfun(@(x) isempty(x.gt), data);
%     data(egt) = [];
%     gt = [gt; cell2mat(cellfun(@(x) x.gt', data, 'UniformOutput', false))];
%     subj = [subj; cellfun(@(x) x.person, data)];
% end

%load('gtproperties.mat','gt1_14')

%this one is no-group case
if(normalize)
    if (gc<0)
        mgt = mean(gt1_14,1)';
        stdgt = std(gt1_14)'/10;
    else
        mgt = zeros(size(gt1_14,2),length(bounds));
        stdgt = zeros(size(gt1_14,2),length(bounds));

        for i=1:size(bounds,2)
            selector = gt1_14(:,grind) <= bounds(2,i) & gt1_14(:,grind) > bounds(1,i);
            mgt(:,i) =  mean(gt1_14(selector,:),1)';
            stdgt(:,i) =  std(gt1_14(selector,:))'/10;
        end
        stdgt = repmat(mean(stdgt,2),1,size(stdgt,2));
    end
else
    if (gc<0)
        mgt = zeros(1,size(gt1_14,2))';
        stdgt = ones(1,size(gt1_14,2))';
    else
        mgt = zeros(size(gt1_14,2),size(bounds,2));
        stdgt = ones(size(gt1_14,2),size(bounds,2));
    end    
end
%rescale bounds
%bounds = (bounds - mgt(2))/stdgt(2)*10;

if (gc>=0)
    fid = fopen([folder 'bounds.txt'],'w');
    for i=1:size(bounds,2)
        fprintf(fid,'%d,%03.2f,%03.2f\n',[(i-1) bounds(1,i) bounds(2,i)]);
    end
    fclose(fid);
    
    fid = fopen([folder 'config.txt'],'w');
    for i=1:size(mgt,2)
        fprintf(fid,['%d' repmat(',%03.2f',1,size(mgt,1))],[i mgt(:,i)']);
        fprintf(fid,[repmat(',%03.2f',1,size(stdgt,1)) '\n'],stdgt(:,i)');        
    end
    fclose(fid);
else
    fid = fopen([folder 'config.txt'],'w');
    fprintf(fid,['1' repmat(',%03.2f',1,length(mgt))],mgt);
    fprintf(fid,[repmat(',%03.2f',1,length(stdgt)) '\n'],stdgt);
end

for i=1:length(persons)
    data = loadFolderContent(persons(i),0);
    ecells = cellfun(@(x) isempty(x), data);
    data(ecells) = [];
    egt = cellfun(@(x) isempty(x.gt), data);
    data(egt) = [];   

    if (i==1)
        if (gc<0)
            createTestTrain( folder, data(1:5:end) , 1, 1,0, 1, angles, 0, mgt, stdgt);
        else
            createTestTrainGrouped(folder, data , 1, 1, 0, 1,  angles, gc, bounds, 0, mgt, stdgt);
        end
    else
        if (gc<0)
            createTestTrain( folder, data(1:5:end) , 1, 1, 0, 1, angles,1, mgt, stdgt);
        else
            createTestTrainGrouped(folder, data , 1, 1,0, 1,  angles, gc, bounds,1 , mgt, stdgt);
        end
    end
end
