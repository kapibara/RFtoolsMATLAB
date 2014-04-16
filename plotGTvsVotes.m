function plotGTvsVotes(votes,gt,coord)

    hold on
    plot([gt(:,2*coord-1) votes(:,2*coord-1)]',...
         [gt(:,2*coord) votes(:,2*coord)]','--k');
 
    plot(votes(:,2*coord-1),...
         votes(:,2*coord),'or');
    plot(gt(:,2*coord-1),...
         gt(:,2*coord),'+g');
    hold off

end