function h = readStats_VotesStats( fid )
    h.point_count = fread(fid,1,'uint32');
    h.vclasses = fread(fid,1,'uint8');
    
    h.votes={};
    
    for i=1:vclasses
        vsize = fread(fid,1,'uint32');
        p = fread(fid,[2 vsize],'uint32')';
        h.votes = [h.votes p];
    end
end

