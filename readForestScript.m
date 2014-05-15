%% read forest; specify 2 functions in options:
% readFeature(fid), readStats(fid)s

options.readFeature = @(fid) readFeature_DepthFeature(fid);
options.visFeature = @(f) visualize_DepthFeature(f);
%options.readStats = @(fid) readStats_ClassStats(fid);
options.readStats = @(fid) readStats_VotesStatsT(fid);
%options.readStats = @(fid) readStats_VotesStats(fid);
options.visStats = @(s) visualize_VotesStatsT(s);
%options.visStats = @(s) visualize_VotesStats(s);
options.elemCount = @(s) count_VotesStatsT(s);
%options.elemCount = @(s) count_VotesStats(s);
options.decisionLevel = 7;

f = fopen( '/home/kuznetso/tmp/DepthHough/Full15_new/09_12_03_03/forest');
fo4 = readForest(f,options);

fclose(f);