function I = readBinImg(fname)
    fid = fopen(fname);
    
    width = fread(fid,1,'int32');
    height = fread(fid,1,'int32');
    
    I = zeros(1,width*height);
    
    p = 1;
    while(p<=width*height)
        numempty = fread(fid,1,'int32');
        p = p + numempty;
        numfull = fread(fid,1,'int32');
        I(p:(p+numfull-1)) = fread(fid,numfull,'uint16');
        p = p + numfull;
    end
    
    fclose(fid);
    
    I = reshape(I,width,height);
end