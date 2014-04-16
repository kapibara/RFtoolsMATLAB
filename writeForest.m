function writeForest(fid,forest, options)
    fwrite(fid,forest.header,'uchar');
    fwrite(fid,forest.majorVersion,'int32');
    fwrite(fid,forest.minorVersion,'int32');
    fwrite(fid,forest.treeCount,'int32');
    for i=1:forest.treeCount
        writeTree(fid,forest.trees{i},options);
    end
end