function gt = R2GT(R)
    gt = zeros(3,1);
    gt(2) = -asin(R(3,1));
    gt(1) = atan2(R(3,2),R(3,3));
    gt(3) = atan2(R(2,1),R(1,1));
    
    gt = gt/(2*pi)*360;
end