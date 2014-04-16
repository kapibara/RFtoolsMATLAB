%% estimation error from multiple experiments

function result = computeErrorsOneFolder()

ptop = '/home/kuznetso/tmp/GroupTest0/TestMerged3/';

folders = dir(ptop);
filter = arrayfun(@(x) (length(x.name)>4) & x.isdir == 1, folders);
folders = folders(filter == 1); %exclude all '.', '..' etc

result = {};

for i=1:length(folders)
    tmp = struct();
    currentFolder = [ptop folders(i).name '/'];
    tmp.folder = currentFolder;
    [tmp.tre, tmp.trvotes, tmp.trgt, tmp.trimg] = errorStats(currentFolder,'_train');
    [tmp.tee, tmp.tevotes, tmp.tegt, tmp.teimg] = errorStats(currentFolder,'_test');
    root = xmlread([currentFolder 'config.xml']);
    tmp.forest = regexp(char(root.getElementsByTagName('forestfile').item(0).getTextContent()),'(forest\d{2})','tokens');
    tmp.forest = tmp.forest{1}{1};
    tmp.tgroup = regexp(char(root.getElementsByTagName('dbfile').item(0).getTextContent()),'(range\d{1})','tokens');
    tmp.tgroup = tmp.tgroup{1}{1};
    result = [result; tmp];
end


end
