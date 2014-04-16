function createTestTrain3DP( outdir, data , ismasked, useCenter, useNT)
    if (~(useCenter) && ~(useNT))
        disp('WARNING: no GT data is written')
    end
    fid = fopen([outdir 'files.txt'],'w');
    
    %write header
    
    if(useCenter)
        fprintf(fid,',r,r,r');
    end
    if(useNT)
        fprintf(fid,',r,r,r');
    end
    fprintf(fid,'\n');
    %write data

    for i=1:length(data)
        I = readBinImg(data{i}.name);

        mask1 = imerode((I>0),strel('rectangle',[5 5]));
        mask2 = imerode((I>0),strel('rectangle',[7 7]));
        h = fspecial('average', [7 7]);
        If = imfilter(I,h,'replicate');
        I = If.*mask2 + (mask1-mask2).*I;

        if (ismasked)
            mask = double(imread(data{i}.mask)')/255; %carefull mask max: 255
            imwrite(uint16(I.*mask),[outdir 'img_' num2str(data{i}.number) '.png']);
        else
            imwrite(uint16(I),[outdir 'img_' num2str(data{i}.number) '.png']);
        end
        
        fprintf(fid,[outdir 'img_' num2str(data{i}.number) '.png']);
        if (useCenter)
            fprintf(fid,',%03.2f,%03.2f,%03.2f',data{i}.gt(1:3));
        end
        if (useNT)
            fprintf(fid,',%03.2f,%03.2f,%03.2f',data{i}.nose);
        end
        fprintf(fid,'\n');
        
    end
    
    fclose(fid);

end

