function createTestTrain( outdir, data , ismasked, issmoothed, useCenter, useAngles, angleCount)
    if (~(useCenter||useAngles))
        disp('WARNING: no GT data is written')
    end
    
    if (~exist('angleCount','var'))
        angleCount = [1 2 3];
    end

    mulCoeff = 1;

    fid = fopen([outdir 'files.txt'],'w');
    
    %write header
    
    if(useCenter)
        fprintf(fid,',r,r');
    end
    if(useAngles)
        fprintf(fid,repmat(',a',1,length(angleCount)));
    end
    fprintf(fid,'\n');
    %write data

    for i=1:length(data)
        I = readBinImg(data{i}.name);
        
        if(issmoothed)
            mask1 = imerode((I>0),strel('rectangle',[5 5]));
            mask2 = imerode((I>0),strel('rectangle',[7 7]));
            h = fspecial('average', [7 7]);
            If = imfilter(I,h,'replicate');
            I = If.*mask2 + (mask1-mask2).*I;
        end
        
        if (ismasked)
            mask = double(imread(data{i}.mask)')/255; %carefull mask max: 255
            imwrite(uint16(I.*mask),[outdir 'img_' num2str(data{i}.number) '.png']);
        else
            imwrite(uint16(I),[outdir 'img_' num2str(data{i}.number) '.png']);
        end
        
        fprintf(fid,[outdir 'img_' num2str(data{i}.number) '.png']);
        if (useCenter)
            fprintf(fid,',%03.2f,%03.2f',data{i}.C2D([2 1]));
        end
        if (useAngles)
            fprintf(fid,',%03.2f,%03.2f,%03.2f',mulCoeff*data{i}.gt(3+angleCount));
        end
        fprintf(fid,'\n');
    end
    
    fclose(fid);

end

