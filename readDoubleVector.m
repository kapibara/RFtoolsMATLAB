function v = readDoubleVector(fid)
    s = fread(fid,1,'uint32');
    v = fread(fid,[s,1],'double');
end