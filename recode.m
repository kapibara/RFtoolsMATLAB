%% recode forests

p = '/home/kuznetso/tmp/CubeExperiment/';
p_out = [p 'forests/'];

mkdir(p_out);

exp_folders = dir([p '2*']);

options.readFeature = @(fid) readFeature_DepthFeature(fid);
options.visFeature = @(f) visualize_DepthFeature(f);
options.readStats = @(fid) readStats_VotesStats(fid);
options.visStats = @(s) visualize_VotesStats(s);
options.elemCount = @(s) count_VotesStats(s);
options.writeFeature = @(fid,feature) writeFeature_DepthFeature(fid,feature);
options.writeStats = @(fid,stats) writeStats_VotesStats(fid,stats);

for i=1:length(exp_folders);
    
    fid_forest = fopen([p exp_folders(i).name '/forest']);
    forest = readForest(fid_forest,options);
    fclose(fid_forest);
    
    fid_file = fopen([p exp_folders(i).name '/log.txt']);
    fname = fgetl(fid_file);
    fclose(fid_file);
    fname = fname(end-14:end-10);
    
    mkdir([p_out fname]);
    
    fid_forest = fopen([p_out fname '/forest'],'w');
    writeForest(fid_forest,forest,options);
    fclose(fid_forest);
end

