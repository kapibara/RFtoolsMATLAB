function F = readFeature_DepthFeature(fid)
    F.ux = fread(fid,1,'int32');
    F.uy = fread(fid,1,'int32');
    F.vx = fread(fid,1,'int32');
    F.vy = fread(fid,1,'int32');
    F.zero = fread(fid,1,'uint16');
end