function I= visualize_VoteStats( stats )
    min12 = min(stats,[],1);
    max12 = max(stats,[],1);

    
    I = zeros(max12(1)-min12(1)+1,max12(2)-min12(2)+1);
    
    stats(:,1) = stats(:,1)- min12(1)+1;
    stats(:,2) = stats(:,2)- min12(2)+1;
    
    for i=1:size(stats,1)
        I(stats(i,1),stats(i,2)) = I(stats(i,1),stats(i,2))+1;
    end
    
    imshow(I/max(max(I)))
end

