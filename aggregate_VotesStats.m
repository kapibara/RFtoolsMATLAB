function [Ims,centers] = aggregate_VotesStatsTStats(stats)

    if(isfield(stats,'map'))
        Ims = stats.map;
        centers = stats.centers;
        return;
    end

    vslength = length(stats.votes);
    Ims = cell(vslength,1);
    centers = cell(vslength,1);
    
    for i=1:vslength
        votes = stats.votes{i};
        
        if(~isempty(votes))

            min12 = min(votes,[],2);
            max12 = max(votes,[],2);

    
            Ims{i} = zeros(max12(1)-min12(1)+1,max12(2)-min12(2)+1);
            centers{i} = 1-min12;
    
            votes(1,:) = votes(1,:)- min12(1)+1;
            votes(2,:) = votes(2,:)- min12(2)+1;
    
            for j=1:size(votes,2)
                Ims{i}(votes(1,j),votes(2,j)) = Ims{i}(votes(1,j),votes(2,j))+1;
            end
        else
            centers{i} = [1; 1];
            Ims{i} = 0;
        end
    end

end