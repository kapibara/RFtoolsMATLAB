function T = readForest(fid,options)
    binaryHeader = 'MicrosoftResearch.Cambridge.Sherwood.Forest';
    T.header = char(fread(fid,length(binaryHeader),'uchar')');
    T.majorVersion =  fread(fid,1,'int32');
    T.minorVersion =  fread(fid,1,'int32');
    T.treeCount = fread(fid,1,'int32');
    T.trees ={};
    for i=1:T.treeCount
        T.trees{i} = readTree(fid,options);
    end
end