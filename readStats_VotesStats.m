function h = readStats_VotesStats( fid )
    h.point_count = fread(fid,1,'uint32');
    h.vclasses = fread(fid,1,'uint8');
    
    votes=cell(1,h.vclasses);
    
    for i=1:h.vclasses
        vsize = fread(fid,1,'uint32');
        p = fread(fid,[2 vsize],'int32');
        votes{i} = p;
    end
    
    h.votes = votes;
end

