function compareTrees(t1,t2)
    for i=1:length(t1.nodes)
        if( t1.nodes(i).bIsLeaf ~= t2.nodes(i).bIsLeaf )
            disp(['bIsLeaf at ' num2str(i) ' differs'])
        end
        
        if( t1.nodes(i).bIsSplit ~= t2.nodes(i).bIsSplit )
            disp(['bIsSplit at ' num2str(i) ' differs'])
        end
        
        if( t1.nodes(i).feature.ux ~= t2.nodes(i).feature.ux || ...
            t1.nodes(i).feature.uy ~= t2.nodes(i).feature.uy)
            disp(['feature at ' num2str(i) ' differs']);
        end
        
        if (t1.nodes(i).threshold ~= t2.nodes(i).threshold )
            disp(['threshold at ' num2str(i) ' differs']);
        end
                
        if (t1.nodes(i).stats.point_count ~= t2.nodes(i).stats.point_count )
            disp(['stats.point_count at ' num2str(i) ' differs']);
        end
        
        if (t1.nodes(i).stats.vclasses ~= t2.nodes(i).stats.vclasses )
            disp(['stats.vclasses at ' num2str(i) ' differs']);
        end
        
        for j=1:t1.nodes(i).stats.vclasses
            if (sum(sum(t1.nodes(i).stats.votes{j} ~= t2.nodes(i).stats.votes{j})) > 0)
                disp(['votes at ' num2str(i) ' and ' num2str(j) ' differs']);
            end
        end
        
        if (isfield(t1.nodes(i).stats,'map'))
            for j=1:length(t1.nodes(i).stats.map)
                if (sum(sum(t1.nodes(i).stats.map{j} ~= t2.nodes(i).stats.map{j})) > 0)
                    disp(['map at ' num2str(i) ' and ' num2str(j) ' differs']);
                end
            end
        
            for j=1:length(t1.nodes(i).stats.map)
                if (sum(sum(t1.nodes(i).stats.map{j} ~= t2.nodes(i).stats.map{j})) > 0)
                    disp(['map at ' num2str(i) ' and ' num2str(j) ' differs']);
                end
            
                if (sum(t1.nodes(i).stats.centers{j} ~= t2.nodes(i).stats.centers{j}) > 0)
                    disp(['centers at ' num2str(i) ' and ' num2str(j) ' differs']);
                end
            end
        end
    end
end
