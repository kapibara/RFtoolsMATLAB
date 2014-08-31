function bounds = generateBounds(minv,maxv,gc,p)

    step = (maxv - minv)/(gc*(1-p) + p);
    nstep = (maxv - minv - p*step)/gc;
    
    div = (minv+p*step/2):nstep:(maxv-p*step/2);
    
    bounds = [div(1:end-1); div(2:end)];
    
    bounds(1,:) = bounds(1,:) - p*step/2;
    bounds(2,:) = bounds(2,:) + p*step/2;

end