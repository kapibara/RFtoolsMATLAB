function tree = mergeTreesStatsT(tree1,tree2,w1,w2)
    nodes1 = tree1.nodes;
    nodes2 = tree2.nodes;
    
    nodes = [];

    for i=1:length(nodes1)
        node = struct();
        %leaf + leaf -> leaf, split + split -> split, leaf + split ->
        %split, leaf + nothing -> leaf, split + nothing -> split
        node.bIsLeaf = (nodes1(i).bIsLeaf && nodes2(i).bIsLeaf) || ...
                       (nodes1(i).bIsLeaf && (~nodes2(i).bIsLeaf && ~nodes2(i).bIsSplit)) || ...
                       ((~nodes1(i).bIsLeaf && ~nodes1(i).bIsSplit) && nodes2(i).bIsLeaf);
        
        node.bIsSplit  = nodes1(i).bIsSplit || nodes2(i).bIsSplit;
        
        node.feature = struct();
        if (nodes1(i).bIsSplit) && (nodes2(i).bIsSplit)
            %both splits
            node.feature.ux = (nodes1(i).feature.ux*w1 + nodes2(i).feature.ux*w2)/(w1+w2);
            node.feature.uy = (nodes1(i).feature.uy*w1 + nodes2(i).feature.uy*w2)/(w1+w2);
            node.feature.vx = (nodes1(i).feature.vx*w1 + nodes2(i).feature.vx*w2)/(w1+w2);
            node.feature.vy = (nodes1(i).feature.vy*w1 + nodes2(i).feature.vy*w2)/(w1+w2);
            node.threshold = (nodes1(i).threshold*w1 + nodes2(i).threshold*w2)/(w1+w2);
            node.feature.zero = nodes1(i).feature.zero;
        elseif nodes1(i).bIsSplit     
            %one split
            node.feature = nodes1(i).feature;
            node.threshold = nodes1(i).threshold;
        elseif nodes2(i).bIsSplit  
            %another split
            node.feature = nodes2(i).feature;
            node.threshold = nodes2(i).threshold;
        else
            %no split
            node.feature.ux = 0;
            node.feature.uy = 0;
            node.feature.vx = 0;
            node.feature.vy = 0;
            node.feature.zero = 1;
            node.threshold = 0;
        end
        
        node.stats = struct();

        elemcount = min(length(nodes1(i).stats.elems),length(nodes2(i).stats.elems));
        if(elemcount>0)
            node.stats.pc = floor((nodes1(i).stats.pc*w1 + nodes2(i).stats.pc*w2)/(w1+w2));
            node.stats.elems = cell(size(nodes1(i).stats.elems));
            for j=1:length(nodes1(i).stats.elems)
                node.stats.elems{j}.vc = floor((nodes1(i).stats.elems{j}.vc*w1 + nodes2(i).stats.elems{j}.vc*w2)/(w1+w2));
                node.stats.elems{j}.dim = nodes1(i).stats.elems{j}.dim;
                %leave votes field empty for now..
                node.stats.elems{j}.votes = [];
            end
        elseif ~isempty(nodes1(i).stats.elems)
            node.stats = nodes1(i).stats;
        elseif ~isempty(nodes2(i).stats.elems)
            node.stats = nodes2(i).stats;
        else
            node.stats.pc = 0;
            node.stats.elems = [];
        end
        % dont do it -> leafs are aggregated as decorators...
        % done separately..
        if(node.bIsLeaf)

            elseif nodes1(i).bIsLeaf

            elseif nodes2(i).bIsLeaf
            
        end
        nodes = [nodes; node];
    end
    
    tree.nodes = nodes;
    tree.header = tree1.header;
    tree.majorVersion = tree1.majorVersion;
    tree.minorVersion = tree1.minorVersion;
end