%% estimation error from multiple experiments

function result = computeErrors()

ptop = '/home/kuznetso/tmp/GroupTest0/';

ptrain = [ptop 'Train/'];
ptest = [ptop 'Test/'];

trainFolders = dir(ptrain);
filter = arrayfun(@(x) (length(x.name)>4) & x.isdir == 1, trainFolders);
trainFolders = trainFolders(filter == 1); %exclude all '.', '..' etc

result = {};

for i=1:length(trainFolders)
    tmp = struct();
    currentFolder = [ptrain trainFolders(i).name '/'];
    tmp.folder = currentFolder;
    [tmp.tre, tmp.trvotes, tmp.trgt, tmp.trimg] = errorStats(currentFolder,'_train');
    [tmp.tee, tmp.tevotes, tmp.tegt, tmp.teimg] = errorStats(currentFolder,'_test');
    root = xmlread([currentFolder 'config.xml']);
%    tmp.uvlimit = str2num(root.getElementsByTagName('uvlimit').item(0).getTextContent());
%    tmp.depth = str2num(root.getElementsByTagName('depth').item(0).getTextContent());
    tmp.range = regexp(char(root.getElementsByTagName('dbfile').item(0).getTextContent()),'(range\d{1})','tokens');
    tmp.range = tmp.range{1}{1};
    result = [result; tmp];
end



testFolders = dir(ptest);
filter = arrayfun(@(x)  (length(x.name)>4) & x.isdir == 1, testFolders);
testFolders = testFolders(filter == 1); %exclude all '.', '..' etc

for i=1:length(testFolders)
    currentFolder = [ptest testFolders(i).name '/'];
    root = xmlread([currentFolder 'config.xml']);
    forestfile = char(root.getElementsByTagName('forestfile').item(0).getTextContent());
    ffname = regexp(forestfile,'(\d{2}_\d{2}_\d{2}_\d{2})','tokens');
    ind = find(arrayfun(@(x) strcmp(x.name,ffname{1}{1}), trainFolders) == 1);
    
    result{ind}.testfolder = testFolders(i).name;
    [result{ind}.e, result{ind}.votes, result{ind}.gt, result{ind}.img] = errorStats([ptest testFolders(i).name '/'],'_test');

end

end
