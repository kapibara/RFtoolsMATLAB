%% serialize fores

p = './forest45';

fid = fopen(p,'w');


options.writeFeature = @(fid,feature) writeFeature_DepthFeature(fid,feature);
options.writeStats = @(fid,stats) writeStats_VotesStats(fid,stats);

writeForest(fid,forest45, options);

fclose(fid);