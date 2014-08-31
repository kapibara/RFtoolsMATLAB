%% compute errors on aggregated stats

function [error,gt,pre] = computeErrorMeanShift(aggs, r, iter)

    error = cell(1,size(aggs{1}.gt,2));
    gt = cell(1,size(aggs{1}.gt,2));
    pre = cell(1,size(aggs{1}.gt,2));

    for i=1:length(aggs)
        current = aggs{i}.agg;
        disp(['processing image ' num2str(i) ' out of ' num2str(length(aggs))]);
        for j=1:size(aggs{i}.gt,2)
             v = current.elems{j}.votes;
             %v(2,:) = v(2,:)/8;
             %aggs{i}.gt(2,j) = aggs{i}.gt(2,j)/8;
             w = current.elems{j}.weights;
             [clustCent,d2c,~] = MeanShiftCluster(v,r,iter,w);
             ucl = unique(d2c);
             h = hist(d2c,ucl);
             %choose the cluster that has the most votes
             [~,ind] = max(h);
             %prediction
             result = clustCent(:,ucl(ind));
             %recompute mean
             newmean  = sum(v(:,d2c == ucl(ind)).*repmat(w(d2c == ucl(ind)),size(v,1),1),2)/sum(w(d2c == ucl(ind)));
             if(isempty(newmean))
                 
                warning('newmean is empty')
                newmean = zeros(3,1); 
             end
             e = abs(aggs{i}.gt(:,j) - newmean);
             error{j} = [error{j}; e'];
             gt{j} = [gt{j}; aggs{i}.gt(:,j)'];
             pre{j} = [pre{j}; newmean'];
        end
    end
end