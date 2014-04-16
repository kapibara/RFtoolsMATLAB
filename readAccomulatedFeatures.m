
function data = readAccomulatedFeatures(p)

fid = fopen(p);

fpn = fread(fid,1,'int32');

data = [];

while(~feof(fid))
    nodeIndex = fread(fid,1,'uint32');
    if(~isempty(nodeIndex))
        features =cell(fpn,1);
        for i=1:fpn
            tmp = struct();
            tmp.F = readFeature_DepthFeature(fid);
            tmp.thr = fread(fid,1,'float');
            tmp.gain = fread(fid,1,'double');
            features{i} = tmp;
        end
        tmp = struct();
        tmp.nodeIndex = nodeIndex;
        tmp.features = features;
        
        gainSize = fread(fid,1,'uint32');
        tmp.gains = fread(fid,[gainSize 1],'double');
        thrSize = fread(fid,1,'uint32');
        tmp.threasholds = fread(fid,[thrSize 1],'float');
        data = [data; tmp];
    end
end

fclose(fid);

end


