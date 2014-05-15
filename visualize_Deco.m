function visualize_Deco(deco)
    [rnum,cnum] = visualize_AggStats( deco.agg );
    
    for i=1:size(deco.gt,2) 
        subplot(rnum,cnum,i)
        hold on
        scatter3(deco.gt(1,i),deco.gt(2,i),deco.gt(3,i),500,'r');
    end
    
end