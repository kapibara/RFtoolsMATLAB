function h = readStats_ClassStats(fid)
    bc = fread(fid,1,'uint8');
    h = fread(fid,bc,'uint64');
end