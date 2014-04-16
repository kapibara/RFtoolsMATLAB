
function hstats= visualize_all_votes()

poses = [];
posesgt = [];

nc = 1;

p = '/home/kuznetso/tmp/FeatureSizeTest/Train/10_18_24_19/';

suffix = '_test';
hstats = {};

for i=0:nc
    fid = fopen([p 'img_443_' num2str(i) suffix]);
    hstats{i+1} = readStats_HoughVotesStats( fid );
    fclose(fid)
    
    [x,y]=find(hstats{i+1}.m==max(max(hstats{i+1}.m)));
    poses = [poses; y(end)-hstats{i+1}.center_y x(end)-hstats{i+1}.center_x];
    posesgt = [posesgt; hstats{i+1}.gt_y hstats{i+1}.gt_x];
    
    cla(gca)
    imshow(hstats{i+1}.m/max(max(hstats{i+1}.m)));
    hold on
    plot(y,x,'or');
    plot(hstats{i+1}.gt_y+hstats{i+1}.center_y,hstats{i+1}.gt_x+hstats{i+1}.center_x,'+g');
    pause
    
end

hold on
plot(poses(:,1),poses(:,2),'+g')
plot(posesgt(:,1),posesgt(:,2),'or')

plot([poses(:,1) posesgt(:,1)]',[poses(:,2) posesgt(:,2)]','--k')

end