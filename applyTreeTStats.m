%% compute estimates for each image

function [votes,img] = applyTreeTStats(tree,leafIds,imgIds,xVals,yVals)

    

    img = unique(imgIds);
    
    
    li = unique(leafIds)+1;
    nc = length(tree.nodes(li(1)).stats.elems);
    votes = zeros(length(img),2*nc); 
    fsdef = [11 11];
    fs = [0 0];
    
    for i=1:length(li)
        [cumvar,vv]=voteVarianceT(tree.nodes(li(i)).stats);
        if (cumvar<1000)
            [Ims,centers] = aggregate_VotesStatsTStats(tree.nodes(li(i)).stats);
            for j=1:length(Ims)
                Ims{j} = Ims{j}/sum(sum(Ims{j}));
            end        
        else
            Ims = cell(length(tree.nodes(li(i)).stats.elems),1);
            Ims = cellfun(@(x) zeros(1,1),Ims,'UniformOutput',false);
            centers = cell(length(tree.nodes(li(i)).stats.elems),1);
            centers = cellfun(@(x) zeros(2,1),centers,'UniformOutput',false);
        end
%         for j=1:length(Ims)
%             fs = min(size(Ims{j}),fsdef);
%             fil = fspecial('average',fs);
%             Ims{j} = imfilter(Ims{j},fil);
%         end       
%        [Ims,centers,modes] = findModes_VotesStats(tree.nodes(li(i)).stats);
        
        tree.nodes(li(i)).stats.map = Ims;
        tree.nodes(li(i)).stats.centers = centers;

    end
    
    step = 10;
    
    for i=1:step:length(img)
        disp(['processing image ' num2str(img(i))]);
        [H,oub,Hcenters] = houghImage(tree, leafIds(imgIds==img(i)),xVals(imgIds==img(i)),yVals(imgIds==img(i)));
        
        for j=1:nc
            [x_p,y_p]=find(H{j}==max(max(H{j})));
            x_p = x_p(end);
            y_p = y_p(end);
            x_p = x_p - Hcenters{j}(1);
            y_p = y_p - Hcenters{j}(2);
            votes(i,[2*j-1 2*j]) = [x_p y_p];
        end
    end
    
    img = img(1:step:end);

end