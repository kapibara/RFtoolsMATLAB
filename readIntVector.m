function v = readIntVector(p)
    fid=fopen(p);
    s = fread(fid,1,'uint32');
    v = fread(fid,[s,1],'int32');
    fclose(fid);
end