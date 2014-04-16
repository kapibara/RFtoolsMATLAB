function writeNode(fid,node,options)
    fwrite(fid,node.bIsLeaf,'uint8');
    fwrite(fid,node.bIsSplit,'uint8');
    options.writeFeature(fid,node.feature);
    fwrite(fid,node.threshold,'float');
    options.writeStats(fid,node.stats);
end