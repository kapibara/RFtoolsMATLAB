function bounds = createTestTrainGrouped( outdir, data , ismasked, issmoothed, useCenter, useAngles, angleCount, gc, bounds, add, mgt, stdgt)
    if (~(useCenter||useAngles))
        disp('WARNING: no GT data is written')
    end
    
    if (~exist('angleCount','var'))
        angleCount = [1 2 3];
    end
    
    if (~exist('add','var'))
        add = 0;
    end

    gtindex = 5;
    
    if(~exist('bounds','var'))
    
        %gtY = cellfun(@(x) x.gt(gtindex), data);
        %range = [min(gtY) max(gtY)];
        range = [ -55 55];
        step = (range(2)-range(1))/gc;
        bounds = range(1):step:range(2);
        bounds(1) = -Inf;
        bounds(end) = +Inf;
        
    else
        
        gc = size(bounds,2);
        
    end
    
    dim = length(data{1}.gt);
    
    if(~exist('mgt','var'))
        mgt = zeros(dim,length(bounds)-1);
        stdgt = ones(dim,length(bounds)-1);
    end
    
    if(~add)
        fid = fopen([outdir 'files.txt'],'w');
    else
        fid = fopen([outdir 'files.txt'],'a');
    end
    gfid = cell(gc,1);
    dir = cell(gc,1);
    for i=1:gc
        dir{i} = ['range' num2str(i) '/'];
        if(~add)
            mkdir([outdir dir{i}] );
            gfid{i} = fopen([outdir dir{i} 'files.txt'],'w');
        else
            gfid{i} = fopen([outdir dir{i} 'files.txt'],'a');
        end
    end
    
    %write header
    if (~add)
        if(useCenter)
            fprintf(fid,',r,r,r');
            for i=1:gc
                fprintf(gfid{i},',r,r,r');  
            end
        end
        if(useAngles)
            fprintf(fid,repmat(',a',1,length(angleCount)));
            for i=1:gc
                fprintf(gfid{i},repmat(',a',1,length(angleCount)));  
            end
        end
        fprintf(fid,'\n');
        for i=1:gc
            fprintf(gfid{i},'\n');  
        end
    end
   

    for i=1:length(data)
        I = readBinImg(data{i}.name);
        gind = find(data{i}.gt(gtindex) <= bounds(2,:) & data{i}.gt(gtindex) > bounds(1,:));
        %rescale
        for j=1:length(gind)
            normalizedGT = (data{i}.gt(3+angleCount) - mgt(3+angleCount,gind(j)))./stdgt(3+angleCount,gind(j));
        
            if(issmoothed)
                mask1 = imerode((I>0),strel('rectangle',[5 5]));
                mask2 = imerode((I>0),strel('rectangle',[7 7]));
                h = fspecial('average', [7 7]);
                If = imfilter(I,h,'replicate');
                I = If.*mask2 + (mask1-mask2).*I;
            end
        
            outputfn = [outdir dir{gind(j)} 'img' num2str(data{i}.person)  '_' num2str(data{i}.number) '.png'];
        
            if (ismasked)
                mask = double(imread(data{i}.mask))/255; %carefull mask max: 255
                imwrite(uint16(I.*mask),outputfn);
            else
                imwrite(uint16(I),outputfn);
            end
        
            fprintf(fid,outputfn);
            fprintf(gfid{gind(j)},outputfn);
        
            if (useCenter)
                fprintf(fid,',%03.2f,%03.2f,%03.2f',data{i}.gt(1:3));
                fprintf(gfid{gind(j)},',%03.2f,%03.2f,%03.2f',data{i}.gt(1:3));
            end
            if (useAngles)
                fprintf(fid,repmat(',%03.2f',1,length(angleCount)),normalizedGT);
                fprintf(gfid{gind(j)},repmat(',%03.2f',1,length(angleCount)),normalizedGT);
            end
            fprintf(fid,'\n');
            fprintf(gfid{gind(j)},'\n');
        end
    end
    
    fclose(fid);
    
    for i=1:gc
        fclose(gfid{i});
    end 

end

