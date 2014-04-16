function [Ims,centers,modes] = findModes_VotesStats(stats)

    if(isfield(stats,'map'))
        Ims = stats.map;
        centers = stats.centers;
        return;
    end

    vslength = length(stats.votes);
    Ims = cell(vslength,1);
    centers = cell(vslength,1);
    modes = cell(vslength,1);
    
    for i=1:vslength
        votes = stats.votes{i};
        
        if(~isempty(votes))
            
            [clustCent,~,cluster2dataCell] = MeanShiftCluster(votes,20,50);
            
            clsizes = cellfun(@(x) length(x), cluster2dataCell);
            [clsizess,ids] = sort(clsizes,'descend');
            totalpr = cumsum(clsizess)/sum(clsizess);
            stopind = find(totalpr>0.9,1,'first');
            clustCent = clustCent(:,ids(1:stopind));
            clsizess = clsizess(1:stopind);
            weights = clsizess/sum(clsizess);

            min12 = min(votes,[],2);
            max12 = max(votes,[],2);
    
            Ims{i} = zeros(max12(1)-min12(1)+1,max12(2)-min12(2)+1);
            centers{i} = 1-min12;
            
            modes{i} = [clustCent; weights'];
    
            clustCent(1,:) = floor(clustCent(1,:)) - min12(1)+1;
            clustCent(2,:) = floor(clustCent(2,:)) - min12(2)+1;
    
            for j=1:size(clustCent,2)
                Ims{i}(clustCent(1,j),clustCent(2,j)) = Ims{i}(clustCent(1,j),clustCent(2,j))+weights(j);
            end
        else
            centers{i} = [1; 1];
            Ims{i} = 0;
        end
    end
end