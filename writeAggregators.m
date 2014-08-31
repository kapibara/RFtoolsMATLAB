function writeAggregators(p,aggs)
    
    fid = fopen(p,'w');
    
    for i=1:length(aggs)
        fwrite(fid,aggs{i}.idx,'int32');
        writeVotesAggregator(fid,aggs{i}.agg);
    end
    
    fclose(fid);
    
end