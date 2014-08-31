function [cumvar,vv] = votesVarianceT(stats)
    vv = zeros(size(stats.elems{1}.votes,1),length(stats.elems));
    for i=1:length(stats.elems)
        votes = stats.elems{i}.votes;
        vv(:,i) = var(votes,1,2);
    end
    cumvar = sum(sum(vv));
end