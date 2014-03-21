function I= visualize_VotesStats( stats )

    vslength = length(stats.votes);
    rnum = floor(sqrt(vslength));
    cnum = vslength/rnum+1;
    
    for i=1:vslength
        votes = stats.votes{i};

        min12 = min(votes,[],2);
        max12 = max(votes,[],2);

    
        I = zeros(max12(1)-min12(1)+1,max12(2)-min12(2)+1);
    
        votes(1,:) = votes(1,:)- min12(1)+1;
        votes(2,:) = votes(2,:)- min12(2)+1;
    
        for j=1:size(votes,2)
            I(votes(1,j),votes(2,j)) = I(votes(1,j),votes(2,j))+1;
        end
    
        subplot(rnum,cnum,i)
        imshow(I/max(max(I)))
        title(['votes: ' num2str(i) '; min x:' num2str(min12(1)) ...
                                    '; min y:' num2str(min12(2)) ...
                                    '; max x:' num2str(max12(1)) ...
                                    '; max y:' num2str(max12(2)) ])
    end
end

