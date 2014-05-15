function agg = readVotesAggregator(fid)
     elemcount = fread(fid,1,'int32');
     
     elems = {};
     
     for i=1:elemcount
         elems = [elems; readVotesAggregatorElem(fid)];
     end
     
     agg.elems = elems;
end

function elem = readVotesAggregatorElem(fid)
    
    vcount = fread(fid,1,'int32');
    dims = fread(fid,1,'int32');
    oricount = fread(fid,1,'int32');

    elem.votes = fread(fid,[dims vcount],'float');
    elem.weights = fread(fid,[1 vcount],'double');
    elem.dims = dims;
    elem.oricount = oricount;

end