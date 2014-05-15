function createTestTrain( outdir, data , ismasked, issmoothed, useCenter, useAngles, angleCount,add,  mgt, stdgt)
    if (~(useCenter||useAngles))
        disp('WARNING: no GT data is written')
    end
    
    if (~exist('angleCount','var'))
        angleCount = [1 2 3];
    end
    
    if (~exist('add','var'))
        add = 0;
    end
    
    dim = length(data{1}.gt);
    
    if(~exist('mgt','var'))
        mgt = zeros(dim,1);
        stdgt = ones(dim,1);
    end

    %write header
    if (~add)
        fid = fopen([outdir 'files.txt'],'w');
        if(useCenter)
            fprintf(fid,',r,r');
        end
        if(useAngles)
            fprintf(fid,repmat(',a',1,length(angleCount)));
        end
        fprintf(fid,'\n');
    else
        fid = fopen([outdir 'files.txt'],'a');
    end
    
    for i=1:length(data)
        I = readBinImg(data{i}.name);
        data{i}.gt(3+angleCount) = (data{i}.gt(3+angleCount) - mgt(3+angleCount))./stdgt(3+angleCount);
        
        if(issmoothed)
            mask1 = imerode((I>0),strel('rectangle',[5 5]));
            mask2 = imerode((I>0),strel('rectangle',[7 7]));
            h = fspecial('average', [7 7]);
            If = imfilter(I,h,'replicate');
            I = If.*mask2 + (mask1-mask2).*I;
        end
        
        outputfn = [outdir 'img' num2str(data{i}.person) '_' num2str(data{i}.number) '.png'];
        
        if (ismasked)
            mask = double(imread(data{i}.mask))/255; %carefull mask max: 255
            imwrite(uint16(I.*mask),outputfn);
        else
            imwrite(uint16(I),outputfn);
        end
        
        fprintf(fid,outputfn);
        if (useCenter)
            fprintf(fid,',%03.2f,%03.2f,%03.2f',data{i}.gt(1:3));
        end
        if (useAngles)
            fprintf(fid,repmat(',%03.2f',1,length(angleCount)),data{i}.gt(3+angleCount));
        end
        fprintf(fid,'\n');
    end
    
    fclose(fid);

end

