function h = readStats_VotesStats( fid )
    h.point_count = fread(fid,1,'uint32');
    h.vclasses = fread(fid,1,'uint8');
%    h.vv = fread(fid,1,'double');
    
    votes=cell(1,h.vclasses);
    
    for i=1:h.vclasses
        vsize = fread(fid,1,'uint32');
        p = fread(fid,[2 vsize],'int32');
        votes{i} = p;
    end
    
    h.votes = votes;
    
    matCount = fread(fid,1,'uint8');
    
    if (matCount > 0)
    
        map = cell(1,matCount);
        centers = cell(1,matCount);
    
        for i=1:matCount
            rows = fread(fid,1,'int16');
            cols = fread(fid,1,'int16');
            map{i} = (fread(fid,[cols,rows],'uint16'))';
            centers{i} = fread(fid,[2 1],'int32');
        end
    
        h.map = map;
        h.centers = centers;
        
    end

end

