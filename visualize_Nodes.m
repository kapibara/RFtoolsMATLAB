function visualize_Nodes(nodes)
%     
%     for i=1:length(nodes)
%         cla(gca)
%         visualize_DepthFeature(nodes{i});
%         title(names{i})
%         pause
%     end
    
    cla(gca)
    allux = cellfun(@(x) x.ux, nodes);
    alluy = cellfun(@(x) x.uy, nodes);
    allvx = cellfun(@(x) x.vx, nodes);
    allvy = cellfun(@(x) x.vy, nodes);
    
    labels = cell(length(allux),1);
    for i=1:length(labels) labels{i} = num2str(i); end
    
    plot([allux zeros(length(allvx),1) allvx]',[alluy zeros(length(allvx),1) allvy]');
    legend(labels);
end