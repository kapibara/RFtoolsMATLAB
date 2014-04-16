fid = fopen('/home/kuznetso/tmp/DepthHOUGH/24_17_01_21/test');

x = [];
y = [];

while(~feof(fid))
    x_tmp = fread(fid,1,'int32');
    if(isempty(x_tmp))
        continue;
    end
    y_tmp = fread(fid,1,'int32');
    x = [x; x_tmp];
    y = [y; y_tmp];
end
fclose(fid);