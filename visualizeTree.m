function visualizeTree(t)
    Ncount = length(t.nodes); %number of nodes
    levels = floor(log2(Ncount+1));
    
    connection = sparse(Ncount,Ncount);
    
    i=1:2^(levels-1)-1;
    %build matrix
    i1 = 2+(i-1)*2;
    i2 = 3+(i-1)*2;
    
    connection(sub2ind(size(connection),i,i1)) = 1;
    connection(sub2ind(size(connection),i,i2)) = 1;
    
    BGobj =biograph(connection);
    
    view(BGobj);
end
