function V = votesVariance(stats,norm)
    V = 0;
    for i=1:length(stats.votes)
        m = mean(stats.votes{i},2);
        delta = stats.votes{i} - repmat(m,1,size(stats.votes{i},2));
        if (~exist('norm','var'))
            V = V + sum(sum(delta.^2));
        else
            V = V + sum(sum(delta.^2))/(size(stats.votes{i},2)-1);
        end
    end
end