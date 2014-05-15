function T = readForest(fid,options)
    binaryHeader = 'MicrosoftResearch.Cambridge.Sherwood.Forest';
    T.header = char(fread(fid,length(binaryHeader),'uchar')');
    T.majorVersion =  fread(fid,1,'int32');
    T.minorVersion =  fread(fid,1,'int32');
    T.treeCount = fread(fid,1,'int32');
    T.trees ={};
    if(T.treeCount > 1 && isfield(options,'decisionLevel'))
        warning('unable to read several trees with decisionLevel option');
        T.treeCount = 1;
    end
    for i=1:T.treeCount
        T.trees{i} = readTree(fid,options);
    end
end