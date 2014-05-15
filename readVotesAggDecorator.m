function deco = readVotesAggDecorator(fid)
    deco.agg = readVotesAggregator(fid);
    if(~feof(fid))
    
        gtlength = length(deco.agg.elems);
        dims = deco.agg.elems{1}.dims;
        deco.gt = fread(fid,[dims gtlength],'float');
        
    end
end