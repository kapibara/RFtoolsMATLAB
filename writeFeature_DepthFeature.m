function writeFeature_DepthFeature(fid,f)
    fwrite(fid,f.ux,'int32');
    fwrite(fid,f.uy,'int32');
    fwrite(fid,f.vx,'int32');
    fwrite(fid,f.vy,'int32');
    fwrite(fid,f.zero,'uint16');
end