%% read forest; specify 2 functions in options:
% readFeature(fid), readStats(fid)s

options.readFeature = @(fid) readFeature_DepthFeature(fid);
options.readStats = @(fid) readStats_ClassStats(fid);

f = fopen('/home/kuznetso/Projects/CPP/DepthRF/testout');
forest = readForest(f,options);