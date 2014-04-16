function bounds = createTestTrain2DPGrouped( outdir, data , ismasked, useCenter, useNT, gc, bounds)
    if (~(useCenter) && ~(useNT))
        disp('WARNING: no GT data is written')
    end
    
    
    gtindex = 5;
    
    if(~exist('bounds','var'))
    
        gtY = cellfun(@(x) x.gt(gtindex), data);
        range = [min(gtY) max(gtY)];
        step = (range(2)-range(1))/gc;
        bounds = range(1):step:range(2);
        bounds(1) = -Inf;
        bounds(end) = +Inf;
        
    else
        
        gc = length(bounds)-1;
        
    end
 
    fid = fopen([outdir 'files.txt'],'w');
    gfid = cell(gc,1);
    dir = cell(gc,1);
    for i=1:gc
        dir{i} = ['range' num2str(i) '/'];
        mkdir([outdir dir{i}] );
        gfid{i} = fopen([outdir dir{i} 'files.txt'],'w');
    end
    
    %write header
    
    if(useCenter)
        fprintf(fid,',r,r');
        for i=1:gc
           fprintf(gfid{i},',r,r');  
        end
    end
    if(useNT)
        fprintf(fid,',r,r');
        for i=1:gc
            fprintf(gfid{i},',r,r');  
        end
    end
    fprintf(fid,'\n');
    for i=1:gc
        fprintf(gfid{i},'\n');  
    end
    %write data

    for i=1:length(data)
        if (~isfield(data{i},'name') || ~isfield(data{i},'gt') || ~isfield(data{i},'mask'))
            continue;
        end
        I = readBinImg(data{i}.name);
        gind = find(data{i}.gt(gtindex) <= bounds, 1,'first')-1; 

        mask1 = imerode((I>0),strel('rectangle',[5 5]));
        mask2 = imerode((I>0),strel('rectangle',[7 7]));
        h = fspecial('average', [7 7]);
        If = imfilter(I,h,'replicate');
        I = If.*mask2 + (mask1-mask2).*I;

        if (ismasked)
            mask = double(imread(data{i}.mask)')/255; %carefull mask max: 255
            imwrite(uint16(I.*mask),[outdir dir{gind}  'img_' num2str(data{i}.number) '.png']);
        else
            imwrite(uint16(I),[outdir dir{gind} 'img_' num2str(data{i}.number) '.png']);
        end
        
        fprintf(fid,[outdir dir{gind} 'img_' num2str(data{i}.number) '.png']);
        fprintf(gfid{gind},[outdir dir{gind} 'img_' num2str(data{i}.number) '.png']);
        if (useCenter)
            fprintf(fid,',%03.2f,%03.2f',data{i}.C2D([2 1]));
            fprintf(gfid{gind},',%03.2f,%03.2f',data{i}.C2D([2 1]));
        end
        if (useNT)
            fprintf(fid,',%03.2f,%03.2f',data{i}.nose2D([2 1]));
            fprintf(gfid{gind},',%03.2f,%03.2f',data{i}.nose2D([2 1]));
        end
        fprintf(fid,'\n');
        fprintf(gfid{gind},'\n');
    end
    
    fclose(fid);
    for i=1:gc
       fclose(gfid{i}); 
    end

end

