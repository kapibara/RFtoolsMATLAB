function v = readDoubleVector(p)
    fid=fopen(p);
    s = fread(fid,1,'uint32');
    v = fread(fid,[s,1],'double');
    fclose(fid);
    
end