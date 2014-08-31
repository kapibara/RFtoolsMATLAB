function [curve ,cumcurve ]= ROCst(gt,pre, anglethrs)
    error = abs(gt-pre);
    curve = zeros(size(gt,2),length(anglethrs));

    for i=1:length(anglethrs)
        curve(:,i) = sum(error<anglethrs(i))/size(error,1);
        cumcurve(i) = sum(sum(error<anglethrs(i),2)==3)/size(error,1);
    end
    
    
end