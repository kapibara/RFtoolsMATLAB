%% description here

function [nodeIds, sizes] = showMajorClasses(folder, imgIdx)

    suffix = '_test';

    n = 3;

    fid = fopen([folder 'leafIds' suffix]);
    leafIds = readIntVector(fid);
    fclose(fid);
    fid = fopen([folder 'imgIds' suffix]);
    imgIds = readIntVector(fid);
    fclose(fid);
    fid = fopen([folder 'xVals' suffix]);
    xVals = readIntVector(fid);
    fclose(fid);
    fid = fopen([folder 'yVals' suffix]);
    yVals = readIntVector(fid);
    fclose(fid);
    
    d = log2(max(leafIds)+1);
    if (floor(d) < d)
        d = floor(d)+1;
    end
    
    leafIdsImg = leafIds(imgIds == imgIdx);
    xValsImg = xVals(imgIds == imgIdx);
    yValsImg = yVals(imgIds == imgIdx);

    dist = hist(leafIdsImg,0:(2^d-2));
    distsorted  = sort(dist,'descend');
    
    nodeIds = find(dist >= distsorted(n))-1;
    sizes = dist(nodeIds+1);
    
    pids = ismember(leafIdsImg,nodeIds);
    [~,colorCode] = histc(leafIdsImg(pids),nodeIds);
    
    subplot(1,3,1)
    scatter(xValsImg(pids),yValsImg(pids),20,colorCode,'fill');
    colorbar('YTick',1:length(nodeIds),'YTickLabel',nodeIds);
    axis equal
    subplot(1,3,2)
    hist(leafIdsImg,0:(2^d-2));
    subplot(1,3,3)
    tmp = leafIdsImg;
    tmp(pids) = [];
    hist(tmp,0:(2^d-2))
end