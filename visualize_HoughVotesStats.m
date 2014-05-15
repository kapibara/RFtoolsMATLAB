function I = visualize_HoughVotesStats( stats )

    I = zeros([size(stats.m,1) size(stats.m,2) 3]);
    
    I(1:size(I,1)*size(I,2)) = stats.m;
    I(size(I,1)*size(I,2)+(1:(size(I,1)*size(I,2)))) = stats.m;
    I(2*size(I,1)*size(I,2)+(1:(size(I,1)*size(I,2)))) = stats.m;
    
    I = I/max(max(stats.m));
   
    gt_shifted = [stats.gt_x + stats.center_x; stats.gt_y + stats.center_y];
    
    I(gt_shifted(1),gt_shifted(2),1) = 1;
    I(gt_shifted(1),gt_shifted(2),2) = 0;
	I(gt_shifted(1),gt_shifted(2),3) = 0;
    
    imshow(I)
end

