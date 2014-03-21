

options.readFeature = @(fid) readFeature_DepthFeature(fid);
options.visFeature = @(f) visualize_DepthFeature(f);
%options.readStats = @(fid) readStats_ClassStats(fid);
options.readStats = @(fid) readStats_VotesStats(fid);
options.visStats = @(s) visualize_VotesStats(s);
options.elemCount = @(s) count_VotesStats(s);

fs = dir('/home/kuznetso/tmp/DepthHOUGH/20_*');

folders = arrayfun(@(x) x.name, fs, 'UniformOutput', false);
%l = cellfun(@(x) x(1)=='1',folders);
%folders = folders(l); 

forests = cell(length(folders),1);

for i=1:length(folders)

    f = fopen(['/home/kuznetso/tmp/DepthHOUGH/' folders{i} '/forest']);
    forests{i}.forest = readForest(f,options);
    ft = fopen(['/home/kuznetso/tmp/DepthHOUGH/' folders{i} '/log.txt']);
    fname = fgetl(ft);
    
    forests{i}.fname = fname(end-14:end-10);

    fclose(ft);
    fclose(f);
    
end