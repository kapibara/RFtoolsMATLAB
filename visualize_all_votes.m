
poses = [];
posesgt = [];

p= '/home/kuznetso/tmp/DepthHOUGH/21_16_10_33/';

for i=0:7
    fid = fopen([p 'img_179676_' num2str(i)]);
    hstats = readStats_HoughVotesStats( fid );
    fclose(fid)
    
    [i,j]=find(hstats.m==max(max(hstats.m)));
    poses = [poses; j(end) i(end)];
    posesgt = [posesgt; hstats.gt_x hstats.gt_y];
    
    
    cla(gca)
    imshow(hstats.m/max(max(hstats.m)));
    hold on
    plot(j,i,'+g');
    plot(hstats.gt_x,hstats.gt_y,'or');
    pause
    
end

hold on
plot(poses(:,1),poses(:,2),'+g')
plot(posesgt(:,1),posesgt(:,2),'or')

plot([poses(:,1) posesgt(:,1)]',[poses(:,2) posesgt(:,2)]','--k')