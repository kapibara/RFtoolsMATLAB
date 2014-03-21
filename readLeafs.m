
fid = fopen('/home/kuznetso/tmp/DepthRFCL/28_13_53_47/leafs');

leafsNodes = [];


options.readFeature = @(fid) readFeature_DepthFeature(fid);
options.readStats = @(fid) readStats_ClassStats(fid);

for i=1:645
    n = readNode(fid,options);
    leafsNodes = [leafsNodes; n];
end

fclose(fid);