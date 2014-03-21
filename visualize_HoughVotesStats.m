function I = visualize_HoughVotesStats( stats )

    I = zeros([size(stats.m,1) size(stats.m,2) 3]);
    
    I(1:size(I,1)*size(I,2)) = stats.m;
    I(size(I,1)*size(I,2)+(1:(size(I,1)*size(I,2)))) = stats.m;
    I(2*size(I,1)*size(I,2)+(1:(size(I,1)*size(I,2)))) = stats.m;
    
    I = I/max(max(stats.m));
    
    %mark gt
    I(stats.gt_x,stats.gt_y,1) = 1;
    I(stats.gt_x,stats.gt_y,2) = 0;
	I(stats.gt_x,stats.gt_y,3) = 0;
    
    imshow(I)
end

