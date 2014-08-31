%aggs is a cell array, representing leafs, 
%            tmp.leafidx = leaf index
%            tmp.agg = aggregated votes
%            tmp.stats = corresponding stats

function result = mergeAgg(aggs1,aggs2,w1,w2)

    leafidx1 = cellfun(@(x) x.leafidx, aggs1);
    leafidx2 = cellfun(@(x) x.leafidx, aggs2);
    
    result = {};
    
    %leafs from aggs1
    diff = setdiff(leafidx1,leafidx2);
    result1= [];
    for i=1:length(diff)
        tmp.idx = diff(i);
        tmp.agg = aggs1{leafidx1== diff(i)}.agg;
        result = [result; tmp];
    end
    
    %leafs from aggs2
    diff = setdiff(leafidx2,leafidx1);

    for i=1:length(diff)
        tmp.idx = diff(i);
        tmp.agg = aggs2{leafidx2== diff(i)}.agg;
        result = [result; tmp];
    end    
    
    %the most difficult
    inter = intersect(leafidx1,leafidx2);
    for i=1:length(inter)
        tmp.idx = inter(i);
        i1 = find(leafidx1 == inter(i));
        i2 = find(leafidx2 == inter(i));
        s1 = aggs1{i1}.stats;
        s2 = aggs2{i2}.stats;
        agg1 = aggs1{i1}.agg;
        agg2 = aggs2{i2}.agg;
        tmp.agg.elems = cell(size(agg1.elems));
        for j = 1:length(tmp.agg.elems)
            tmp.agg.elems{j}.dims = agg1.elems{j}.dims;
            ssize1 = s1.elems{j}.vc;
            ssize2 = s2.elems{j}.vc;
            ww1 = ssize1*w1/(ssize1*w1+ssize2*w2);
            ww2 = ssize2*w2/(ssize1*w1+ssize2*w2);
            tmp.agg.elems{j}.weights = [agg1.elems{j}.weights*ww1 agg2.elems{j}.weights*ww2];
            tmp.agg.elems{j}.votes = [agg1.elems{j}.votes agg2.elems{j}.votes];
        end
        result = [result; tmp];
    end

end