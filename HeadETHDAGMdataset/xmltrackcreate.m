
xmlfile = '/home/kuznetso/Projects/CPP/DepthRF/head_track.xml';
trainfolder = '/home/kuznetso/tmp/GroupTestD15wi10FullNorm/';
dbfolder = '/home/kuznetso/tmp/HoughTests/Head_angles3D_gri10norm/';

subf = dir([trainfolder 'te*']);

ranges = csvread([dbfolder '/bounds.txt']);
ranges(:,1) = ranges(:,1)+1;
multipliers = csvread([dbfolder '/config.txt']);


%mean value
meanind = 5:7;
%standard deviation
stdind = 11:13;

froot=xmlread(xmlfile);

forests=(froot.getElementsByTagName('forests').item(0));

for i=1:length(subf)
    infolder = dir([trainfolder subf(i).name '/09*']);
    fofile = [trainfolder subf(i).name '/' infolder(1).name '/forest'];
    rangeind = regexp(subf(i).name,'(\d{1,2})','tokens');
    rangeind = str2num(rangeind{1}{1});
    
    ulb = ranges(ranges(:,1) == rangeind,2:3);
    if(isinf(ulb(1)))
        ulb(1) = - 100000;
    end
    if(isinf(ulb(2)))
        ulb(2) =  100000;
    end
    felem = froot.createElement('forest');
    tmp = froot.createElement('forestfile');
    tmp.appendChild(froot.createTextNode(fofile));
    felem.appendChild(tmp);
    % cluster bounds
    tmp = froot.createElement('bounds');
    tmp.appendChild(froot.createTextNode(sprintf('%03.2f,%03.2f',ulb)));
    felem.appendChild(tmp);
    
    % standard deviation
    tmp = froot.createElement('std');
    stdval = multipliers(multipliers(:,1) == rangeind,stdind);
    tmp.appendChild(froot.createTextNode(sprintf('%03.2f,%03.2f,%03.2f',stdval)));
    felem.appendChild(tmp);
    
    % mean
    tmp = froot.createElement('mean');
    meanval = multipliers(multipliers(:,1) == rangeind,meanind);
    tmp.appendChild(froot.createTextNode(sprintf('%03.2f,%03.2f,%03.2f',meanval)));
    felem.appendChild(tmp);
    forests.appendChild(felem);
end

xmlwrite([xmlfile(1:end-4) '_10Full.xml'],froot);
