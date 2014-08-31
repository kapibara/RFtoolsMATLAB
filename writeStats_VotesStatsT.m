function writeStats_VotesStatsT(fid,stats)
    fwrite(fid,length(stats.elems),'int8');
    fwrite(fid,stats.pc,'uint32');
    for i=1:length(stats.elems)
        writeStats_VotesStatsElem(fid,stats.elems{i})
    end
end

function writeStats_VotesStatsElem(fid,stats)
    fwrite(fid,stats.vc,'uint32');
    fwrite(fid,stats.dim,'int32');
    fwrite(fid,size(stats.votes,2),'int32');
    fwrite(fid,stats.votes,'float');
end