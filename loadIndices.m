function [imgIds,leafIds,xVals,yVals] = loadIndices(p, suffix)

if (~exist('suffix','var'))
    suffix = '_test';
end

fid = fopen([p 'imgIds' suffix]);
imgIds = readIntVector(fid);
fclose(fid);

fid = fopen([p 'leafIds' suffix]);
leafIds = readIntVector(fid);
fclose(fid);

fid = fopen([p 'xVals' suffix]);
xVals = readIntVector(fid);
fclose(fid);

fid = fopen([p 'yVals' suffix]);
yVals = readIntVector(fid);
fclose(fid);

end