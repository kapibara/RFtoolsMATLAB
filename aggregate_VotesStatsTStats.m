function [Ims,centers] = aggregate_VotesStatsTStats(stats)

    if(isfield(stats,'map'))
        Ims = stats.map;
        centers = stats.centers;
        return;
    end

    vslength = length(stats.elems);
    Ims = cell(vslength,1);
    centers = cell(vslength,1);
    
    for i=1:vslength
        votes = stats.elems{i}.votes;
        
        [Ims{i},centers{i}] = aggregateVotes(votes);
    end

end