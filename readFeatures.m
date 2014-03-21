function data = readFeatures(fid)
    fpn = fread(fid,1,'int32');
    maxLevels = fread(fid,1,'int32');
    
    nc = 2^maxLevels-1;
    data = cell(nc,1);
    
    for i=1:nc
        nodeIndex = fread(fid,1,'int32');
        if (feof(fid))
            return;
        end
        data{nodeIndex+1} = cell(fpn,1);
        for j=1:fpn
            data{nodeIndex+1}{j} = readFeature_DepthFeature(fid);
        end
    end
end