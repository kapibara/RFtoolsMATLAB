function v = readIntVector(fid)
    s = fread(fid,1,'uint32');
    v = fread(fid,[s,1],'int32');
end