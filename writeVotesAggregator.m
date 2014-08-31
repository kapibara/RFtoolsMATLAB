function writeVotesAggregator(fid,agg)

    fwrite(fid,length(agg.elems),'int32');
    
    for i=1:length(agg.elems)
        writeVotesAggregatorElem(fid,agg.elems{i});
    end

end

function writeVotesAggregatorElem(fid,elem)

    fwrite(fid,length(elem.weights),'int32');
    fwrite(fid,size(elem.votes,1),'int32');
    
    fwrite(fid,elem.votes,'float');
    fwrite(fid,elem.weights,'double');
end