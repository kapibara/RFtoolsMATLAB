function [Ims,centers] = aggregateVotes(votes)
    
    if(~isempty(votes))

        min12 = floor(min(votes,[],2));
        max12 = ceil(max(votes,[],2));

    
        Ims = zeros(max12(1)-min12(1)+1,max12(2)-min12(2)+1);
        centers = 1-min12;
    
        votes(1,:) = round(votes(1,:)- min12(1)+1);
        votes(2,:) = round(votes(2,:)- min12(2)+1);
    
        for j=1:size(votes,2)
            Ims(votes(1,j),votes(2,j)) = Ims(votes(1,j),votes(2,j))+1;
        end
    else
        centers = [1; 1];
        Ims = 0;
    end

end