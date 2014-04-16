

options.readFeature = @(fid) readFeature_DepthFeature(fid);
options.visFeature = @(f) visualize_DepthFeature(f);
%options.readStats = @(fid) readStats_ClassStats(fid);
options.readStats = @(fid) readStats_VotesStats(fid);
options.visStats = @(s) visualize_VotesStats(s);
options.elemCount = @(s) count_VotesStats(s);

p = '/home/kuznetso/tmp/CubeExperiment/forests/';

fs = dir([p '0*']);

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
    
    f = fopen([p folders{i} '/forest']);
    forests{i}.forest = readForest(f,options);
%    ft = fopen([p folders{i} '/log.txt']);
%    fname = fgetl(ft);
    
%    data = readAccomulatedFeatures([p folders{i} '/accomulatedFeatures']);
    ind = arrayfun(@(x)x.nodeIndex,data);
    
%    accFeatures{i}.features = data(ind==nodeIndex).features;
    
    forests{i}.fname = folders{i};%fname(end-14:end-10);

%    fclose(ft);
    fclose(f);
    
end

% get nodes with id 0