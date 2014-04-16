function showFeatures(nodes, tstring)
%     
%     for i=1:length(nodes)
%         cla(gca)
%         visualize_DepthFeature(nodes{i});
%         title(names{i})
%         pause
%     end
    
%    cla(gca)
    if(~exist('tstring','var'))
        tstring = '';
    end

    allux = cellfun(@(x) x.F.ux, nodes);
    alluy = cellfun(@(x) x.F.uy, nodes);
    allvx = cellfun(@(x) x.F.vx, nodes);
    allvy = cellfun(@(x) x.F.vy, nodes);
    
    labels = cell(length(allux),1);
    for i=1:length(labels) labels{i} = num2str(i); end
    
    plot([allux zeros(length(allvx),1) allvx]',[alluy zeros(length(allvx),1) allvy]');
    legend(labels);
    title(tstring);
end