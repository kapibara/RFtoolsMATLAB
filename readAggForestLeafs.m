function aggs = readAggForestLeafs(p, stats)
    if(~exist('stats','var'))
        stats = 0;
    end

    fid = fopen(p);
    
    tcount = fread(fid,1,'int32');
    maxnodes = fread(fid,1,'int32');
    votesCount = fread(fid,1,'int32');
    aggs = cell(tcount,1);
    
    for i=1:tcount
        nodeCount = fread(fid,1,'int32');
        aggs{i} = cell(nodeCount,1);
        for j=1:nodeCount
            aggs{i}{j}.leafidx = fread(fid,1,'int32');
            aggs{i}{j}.agg = readVotesAggregator(fid); 
            if(stats)
                aggs{i}{j}.stats = readStats_VotesStatsT(fid);
            end
        end
    end
end