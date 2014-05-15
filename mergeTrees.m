function tree = mergeTrees(tree1,tree2,w1,w2)
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
        node.stats.point_count = floor((nodes1(i).stats.point_count*w1 + nodes2(i).stats.point_count*w2)/(w1+w2));
        if (nodes1(i).stats.vclasses>0)
            node.stats.vclasses = nodes1(i).stats.vclasses;
            node.stats.votes = cell(size(nodes1(i).stats.votes));
        else
            node.stats.vclasses = nodes2(i).stats.vclasses;
            node.stats.votes = cell(size(nodes2(i).stats.votes));        
        end
        % dont do it -> leafs are aggregated as decorators...
        if(node.bIsLeaf)
            if(nodes1(i).bIsLeaf && nodes2(i).bIsLeaf)
                
                %% aggregate leafs (this is VotesStats version)
                node.stats.map = cell(node.stats.vclasses,1);
                node.stats.centers = cell(node.stats.vclasses,1);
                [Ims1,centers1] = aggregate_VotesStats(nodes1(i).stats);
                [Ims2,centers2] = aggregate_VotesStats(nodes2(i).stats);
                for j=1:node.stats.vclasses
                    min1 = - centers1{j}+1;
                    max1 = min1 + [size(Ims1{j},1)-1; size(Ims1{j},2)-1];
                    min2 = - centers2{j}+1;
                    max2 = min2 + [size(Ims2{j},1)-1; size(Ims2{j},2)-1];
               
                    omin = min(min1,min2);
                    omax = max(max1,max2);
               
                    range1x = ((min1(1)-omin(1)):(max1(1)-omin(1)))+1;
                    range1y = ((min1(2)-omin(2)):(max1(2)-omin(2)))+1;
               
                    range2x = ((min2(1)-omin(1)):(max2(1)-omin(1)))+1;
                    range2y = ((min2(2)-omin(2)):(max2(2)-omin(2)))+1;
               
                    node.stats.map{j} = zeros(omax(1)-omin(1)+1,omax(2)-omin(2)+1);
                    node.stats.centers{j} = 1 - omin;
                    node.stats.map{j}(range1x,range1y) = node.stats.map{j}(range1x,range1y) + Ims1{j};
                    node.stats.map{j}(range2x,range2y) = node.stats.map{j}(range2x,range2y) + Ims2{j};
                    node.stats.map{j} = node.stats.map{j}/2;
                end
                
                %% aggregate leafs (this is 'Decorated' version)
            %aggregate votes map :(
            elseif nodes1(i).bIsLeaf
                node.stats.votes = nodes1(i).stats.votes;
            elseif nodes2(i).bIsLeaf
                node.stats.votes = nodes2(i).stats.votes;
            end
        end
        nodes = [nodes; node];
    end
    
    tree.nodes = nodes;
    tree.header = tree1.header;
    tree.majorVersion = tree1.majorVersion;
    tree.minorVersion = tree1.minorVersion;
end