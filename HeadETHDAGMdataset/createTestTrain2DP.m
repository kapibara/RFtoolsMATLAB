function createTestTrain2DP( outdir, data , ismasked, useCenter, useNT)
    if (~(useCenter) && ~(useNT))
        disp('WARNING: no GT data is written')
    end
    fid = fopen([outdir 'files.txt'],'w');
    
    %write header
    
    if(useCenter)
        fprintf(fid,',r,r');
    end
    if(useNT)
        fprintf(fid,',r,r');
    end
    fprintf(fid,'\n');
    %write data

    for i=1:3
        I = readBinImg(data{i}.name);

        mask1 = imerode((I>0),strel('rectangle',[5 5]));
        mask2 = imerode((I>0),strel('rectangle',[7 7]));
        h = fspecial('average', [7 7]);
        If = imfilter(I,h,'replicate');
        I = If.*mask2 + (mask1-mask2).*I;
        
        outputfn = [outdir 'img' num2str(data{i}.person) '_' num2str(data{i}.number) '.png'];

        if (ismasked)
            mask = double(imread(data{i}.mask)')/255; %carefull mask max: 255
            imwrite(uint16(I.*mask),outputfn);
        else
            imwrite(uint16(I),outputfn);
        end
        
        fprintf(fid,outputfn);
        if (useCenter)
            fprintf(fid,',%03.2f,%03.2f',data{i}.C2D([2 1]));
        end
        if (useNT)
            fprintf(fid,',%03.2f,%03.2f',data{i}.nose2D([2 1]));
        end
        fprintf(fid,'\n');
    end
    
    fclose(fid);

end

