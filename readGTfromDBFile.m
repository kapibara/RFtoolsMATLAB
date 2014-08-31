function gt = readGTfromDBFile(p)

    fid = fopen([p 'files.txt']);
    
    header = fgetl(fid);
    
    gt = [];
    
    s= 3;
    
    while(~feof(fid))
        line = fgetl(fid);
        res = regexp(line,'([0-9\.\-]{4,6})','tokens');
        numbers = cellfun(@(x) str2double(x{1}),res);
        %if(~isempty(gt))
            %s = size(gt,2);
            gt = [gt; numbers((end-s+1):end)];
        %else
        %    gt = [gt; numbers];
        %end
        
    end
    
    fclose(fid);

end