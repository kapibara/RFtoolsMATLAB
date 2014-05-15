%% serialize fores

p = '/home/kuznetso/Projects/CPP/DepthRF/test/forest';

fid = fopen(p,'w');


options.writeFeature = @(fid,feature) writeFeature_DepthFeature(fid,feature);
options.writeStats = @(fid,stats) writeStats_VotesStatsT(fid,stats);

writeForest(fid,forest, options);

fclose(fid);