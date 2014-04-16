%% compute estimates for each image

function [result,more] = applyTreeMS(tree,leafIds,imgIds,xVals,yVals)

    nc = 2;

    img = unique(imgIds);
  
    li = unique(leafIds)+1;

    
    leafs = cell(length(tree.nodes),1);
    
    vslength = length(tree.nodes(li(1)).stats.votes);
    
    for i=1:length(li)    
        [~,~,modes] = findModes_VotesStats(tree.nodes(li(i)).stats);
        leafs{li(i)} = modes;
    end
    
    step = 10;
    
    result = zeros(length(img),vslength*2);
    more = cell(length(img),1);
    
    for i=1:step:length(img)
        disp(['processing image ' num2str(img(i))]);
%        [H,oub,Hcenters] = houghImage(tree, leafIds(imgIds==img(i)),xVals(imgIds==img(i)),yVals(imgIds==img(i)), 1);

        for j=1:vslength
            curli = leafIds(imgIds==img(i))+1;
            curx = xVals(imgIds==img(i));
            cury = yVals(imgIds==img(i));
            modes = cellfun(@(x) x{j}, leafs(curli), 'UniformOutput', false);
            
            allvotes = [];
            
            for k=1:length(curx)
                votes = repmat([curx(k); cury(k)],1,size(modes{k}(1:2,:),2)) + modes{k}(1:2,:);
                allvotes = [allvotes; votes' modes{k}(3,:)'];
            end
            
            more{i} = allvotes;
            
            [clustCent,~,cluster2dataCell] = MeanShiftCluster(allvotes(:,1:2)',20,50,allvotes(:,3)');
            
            s =cellfun(@(x) length(x),cluster2dataCell);
            [~,ind]= max(s);
           
            result(i,2*j-1:2*j) = clustCent(:,ind)';
            
        end

    end
    
    img = img(1:step:end);

end