function h = readStats_ClassStats(fid)
    bc = fread(fid,1,'uint8');
    samplecount = fread(fid,1,'uint64');
    h = fread(fid,bc,'uint64');
    if(sum(h)~= samplecount)
        warning('classStats is inconsistent')
    end
end