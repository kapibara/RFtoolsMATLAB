function N = readNode(fid,options)
    N.bIsLeaf = fread(fid,1,'uint8');
    N.bIsSplit= fread(fid,1,'uint8');
    N.feature = options.readFeature(fid);
    N.threshold = fread(fid,1,'float');
    N.stats = options.readStats(fid);
end