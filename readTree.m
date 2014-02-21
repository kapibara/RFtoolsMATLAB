function T = readTree(fid,options)
    binaryHeader = 'MicrosoftResearch.Cambridge.Sherwood.Tree';
    T.header = char(fread(fid,length(binaryHeader),'uchar')');
    
    T.majorVersion=fread(fid,1,'int32');
    T.minorVersion=fread(fid,1,'int32');
    
    if(T.majorVersion==0 && T.minorVersion==0)
       decisionLevel = fread(fid,1,'int32');
       if(decisionLevel<=0)
           warning('invalid data')
       end
       nodeCount = 2^(decisionLevel+1)-1;
       
       nodes = [];
       for i=1:nodeCount
           nodes = [nodes readNode(fid,options)];
       end    
       
       T.nodes = nodes;
    end
end
