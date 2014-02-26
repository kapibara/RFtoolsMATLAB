%% read forest; specify 2 functions in options:
% readFeature(fid), readStats(fid)s

options.readFeature = @(fid) readFeature_DepthFeature(fid);
options.readStats = @(fid) readStats_VotesStats(fid);

f = fopen('C:/Data/Development/CPP/DepthRF/hforest');
forest = readForest(f,options);

fclose(f);