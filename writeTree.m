function writeTree(fid,tree,options)
    fwrite(fid,tree.header,'uchar');
    fwrite(fid,tree.majorVersion,'int32');
    fwrite(fid,tree.minorVersion,'int32');
    
    decisionLevel = log2(length(tree.nodes) + 1)-1;
    fwrite(fid,decisionLevel,'int32');
    
    for i=1:length(tree.nodes)
        writeNode(fid,tree.nodes(i),options);
    end
end