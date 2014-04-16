function dist = jointPositionChanges(file)
    files = readtable(file,'ReadVariableNames',0);
    coords = files(:,2:end);
    
    coords = table2array(coords);
    
    mcoords = mean(coords);
    
    xcoords = 1:2:size(coords,2);
    ycoords = 2:2:size(coords,2);
    
    dist = coords - repmat(mcoords,size(coords,1),1);
    
    dist = sqrt(dist(:,xcoords).^2 + dist(:,ycoords).^2);
end