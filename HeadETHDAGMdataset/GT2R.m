function R = GT2R(gt)
    gt = gt/360*(2*pi);
    R1 = [1 0 0; 0 cos(gt(1)) -sin(gt(1)); 0 sin(gt(1)) cos(gt(1))];
    R2 = [cos(gt(2)) 0 sin(gt(2)); 0 1 0; -sin(gt(2)) 0 cos(gt(2))];
    R3 = [cos(gt(3)) -sin(gt(3)) 0; sin(gt(3)) cos(gt(3)) 0; 0 0 1];
    
    R = R3*R2*R1;

end