function gt = readGT(fname)
    fid = fopen(fname);
    gt = fread(fid,6,'float');
    fclose(fid);
end