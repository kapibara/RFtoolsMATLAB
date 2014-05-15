

options.readFeature = @(fid) readFeature_DepthFeature(fid);
options.visFeature = @(f) visualize_DepthFeature(f);
%options.readStats = @(fid) readStats_ClassStats(fid);
options.readStats = @(fid) readStats_VotesStatsT(fid);
options.visStats = @(s) visualize_VotesStatsT(s);
options.elemCount = @(s) count_VotesStatsT(s);
options.decisionLevel = 3;

p = '/home/kuznetso/tmp/GroupTestD15wi10FullNorm/';

fs = dir([p 'te*']);

%don't make it a folder date value

folders = arrayfun(@(x) x.name, fs, 'UniformOutput', false);
% times = cellfun(@(x) maxtime - name2time(x),folders,'UniformOutput', false);
% isincluded = cellfun(@(x) x(find(x~=0, 1, 'first')), times);
% isincluded = (isincluded > 0);
% folders = folders(isincluded);

forests = cell(length(folders),1);
%accFeatures = cell(length(folders),1);

nodeIndex = 0;

for i=1:length(folders)
    
    fo1= dir([p folders{i} '/09*']);
    
    f = fopen([p folders{i} '/' fo1(1).name '/forest']);
    forests{i}.forest = readForest(f,options);
%    ft = fopen([p folders{i} '/log.txt']);
%    fname = fgetl(ft);
    
%    data = readAccomulatedFeatures([p folders{i} '/accomulatedFeatures']);
%    ind = arrayfun(@(x)x.nodeIndex,data);
    
%    accFeatures{i}.features = data(ind==nodeIndex).features;
    
    forests{i}.fname = folders{i};%fname(end-14:end-10);

%    fclose(ft);
    fclose(f);
    
end

% get nodes with id 0