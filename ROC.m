function [curves,error,gt,pre] = ROC(aggs, anglethrs, r, iter)

    [error,gt,pre] = computeErrorMeanShift(aggs, r, iter);
    
    
    curves = cell(1,length(error));

    for j=1:length(gt)
        curves{j} = ROCst(gt{j},pre{j}, anglethrs);
    end

end