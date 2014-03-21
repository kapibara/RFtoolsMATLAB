%% read forest; specify 2 functions in options:
% readFeature(fid), readStats(fid)s

options.readFeature = @(fid) readFeature_DepthFeature(fid);
options.visFeature = @(f) visualize_DepthFeature(f);
%options.readStats = @(fid) readStats_ClassStats(fid);
options.readStats = @(fid) readStats_VotesStats(fid);
options.visStats = @(s) visualize_VotesStats(s);
options.elemCount = @(s) count_VotesStats(s);

f = fopen('/home/kuznetso/tmp/DepthHOUGH/21_19_46_31/forest');
forest = readForest(f,options);

fclose(f);