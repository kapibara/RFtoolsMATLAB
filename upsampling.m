function norm = upsampling(param,bins)

    if(~exist('bins','var'))
        bins = 2*ones(size(param,2));
    end
    
    thr = 10;
    
    minp = min(param);
    maxp = max(param);
    
    bounds = cell(1,size(minp,2));
    
    for i=1:size(minp,2)
        bounds{i} = minp(i):(maxp(i)-minp(i))/bins(i):maxp(i);
    end
    
    ind = zeros(size(param));
    
    for i=1:size(param,2)
        [~,ind(:,i)] = histc(param(:,i),bounds{i});
    end
    
    [C,ia,ic] = unique(ind,'rows');
    
    uic = unique(ic);
    
    ns = hist(ic,uic);
    
    elecount = ceil(mean(ns(ns/sum(ns)>1/length(uic))));
    
    norm = [];
    
    for i=1:length(ia)
            indices = find(ic == uic(i));
            if (length(indices)>thr)
                subsamples = randi(length(indices),[elecount 1]);
                norm = [norm; indices(subsamples)];
            else
                norm = [norm; indices];
            end
    end

end