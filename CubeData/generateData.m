%% set up camera:

%f_x = 534.03613;
%f_y = 534.22957;
fx = 534.03613;
fy = 534.22957;
cx = 120;
cy = 160;
intParam = [fx 0 cx; 0 fy cy; 0 0 1];
C = CCamera(intParam);

[v,f] = box3d([6 2 3]);
v = 20*v;
t = [0 0 1000];

interval = 80;

%thetaz = 20;
%thetax = -interval:2:interval;
%thetay = 20;
thetax = -70:5:-50;
thetay = -70:5:-50;
thetaz = -70:5:-50;

sideDivision = 6;

realDivision = ceil(length(thetax)/sideDivision);

path = '/home/kuznetso/tmp/HoughTests/Cube_tmp/';
group = 'g';
base = 'cube';
ic = 1;

dbfile = fopen([path 'files.txt'],'w');
cornersx = [];
cornersy = [];

for i=1:length(thetaz)
    Rz = [cos(thetaz(i)/360*(2*pi)) sin(thetaz(i)/360*(2*pi)) 0; -sin(thetaz(i)/360*(2*pi)) cos(thetaz(i)/360*(2*pi)) 0; 0 0 1];
    for j=1:length(thetay)
        Ry = [cos(thetay(j)/360*(2*pi)) 0 sin(thetay(j)/360*(2*pi)); 0 1 0; -sin(thetay(j)/360*(2*pi)) 0 cos(thetay(j)/360*(2*pi))];
        for k=1:length(thetax)
            Rx = [1 0 0; 0 cos(thetax(k)/360*(2*pi)) sin(thetax(k)/360*(2*pi)); 0 -sin(thetax(k)/360*(2*pi)) cos(thetax(k)/360*(2*pi))];
            R = Rx*Ry*Rz;
            
            v1 = (R*v' + repmat(t',1,size(v,1)))';
            
            [proj,depthpr,visible,depth,mask] = C.isVisibleR(v1,f);
            
            cornersx = [cornersx proj(:,1)];
            cornersdthry = [cornersy proj(:,2)];
            
            depth = depth.*mask;
                      
            fname = [path base sprintf('%02d_%02d_%02d',interval + thetax(k),interval + thetay(j),interval + thetaz(i)) '.png'];
            
            imwrite(uint16(depth),fname);
            
            fprintf(dbfile,fname);
            
            for l=1:size(proj,1)
                fprintf(dbfile,',%03.2f,%03.2f',proj(l,1),proj(l,2));
            end
            
            fprintf(dbfile,'\n');

            if(sum(sum(mask))==0)
                warning('mask is empty');
                break;
            end
            
            ic = ic+1;
        end
    end
end

fclose(dbfile);

