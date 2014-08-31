%% compute ROC curves for all ranges

ptop = '/home/kuznetso/tmp/GroupTestD15wFull/Test/';

folders = dir(ptop);
filter = arrayfun(@(x) (length(x.name)>4) & x.isdir == 1, folders);
folders = folders(filter == 1); %exclude all '.', '..' etc

result = {};

r = 8;
iter = 30;

for i=1:length(folders)
    disp(folders(i).name)
    tmp = struct();
    currentFolder = [ptop folders(i).name '/'];
    tmp.folder = currentFolder;
    aggs = readAggregators([currentFolder 'aggVotes'],1);
    if(~isempty(aggs))
        [tmp.curves, error,tmp.gt,tmp.pre] = ROC(aggs, [5 10 15 20 25 30], r, iter);
        tmp.mean = mean(error{1});
        root = xmlread([currentFolder 'config.xml']);
        tmp.tgroup = regexp(char(root.getElementsByTagName('dbfile').item(0).getTextContent()),'(range\d{1,2})','tokens');
        tmp.tgroup = tmp.tgroup{1}{1};
        result = [result; tmp];
    end
end