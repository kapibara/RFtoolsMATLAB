function visualizeTree(t,options)
    Ncount = length(t.nodes); %number of nodes
    levels = floor(log2(Ncount+1));
    
    connection = sparse(Ncount,Ncount);
    
    i=1:2^(levels-1)-1;
    %build matrix
    i1 = 2+(i-1)*2;
    i2 = 3+(i-1)*2;
    
    
    ids =cell(Ncount,1);
    for j=1:Ncount
        ids{j}= num2str(j);
    end
    
%    elemcoutn = arrayfun(@(x) sum(x.stats), t.nodes);
    
    connection(sub2ind(size(connection),i,i1)) = 1;
    connection(sub2ind(size(connection),i,i2)) = 1;
    
    BGobj = biograph(connection,ids,'NodeCallback',@(node) onnodeclick(node,t,options));
    
    bgView = view(BGobj);
    
    bgView.CustomNodeDrawFcn =  @(node) drawNode(node,t,options);
end

function onnodeclick(node,t,options)
    id = str2double(get(node,'ID'));
    n = t.nodes(id);
    
    
    
    figure(6);
    cla(gca);
    
    if (n.bIsLeaf)
        options.visStats(n.stats);
    elseif (n.bIsSplit)
        
        options.visFeature(n.feature);
        title(n.threshold);
    end
    
%    figure(7);
%    cla(gca);
%    options.visFeatures(n.feature);
    
end
