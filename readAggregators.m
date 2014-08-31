function aggs = readAggregators(p,aggonly)
    if(~exist('aggonly','var'))
        aggonly = 0;
    end
    fid = fopen(p);
    aggs = {};
    while(~feof(fid))
        if(~aggonly)
            tmp.leafidx = fread(fid,1,'int32');
            tmp.agg = readVotesAggregator(fid);
            tmp.stats = readStats_VotesStatsT(fid);
        else
            tmp = readVotesAggDecorator(fid);
        end
        aggs = [aggs; tmp];
    end
    aggs = aggs(1:end-1); %remove the last empty aggregation
    
    fclose(fid);
end