function stats = readStats_VotesStatsT(fid)
    
    vecount = fread(fid,1,'int8');
    stats.pc = fread(fid,1,'uint32');
    stats.elems = cell(vecount,1);
    for i=1:vecount
        stats.elems{i} = readStats_VotesStatsElem(fid);
    end
end

function vse = readStats_VotesStatsElem(fid)
    vc = fread(fid,1,'uint32');
    s = fread(fid,1,'int32');
    c = fread(fid,1,'uint32');
    votes = fread(fid,[s c],'float');
    vse.vc = vc;
    vse.votes = votes;
end