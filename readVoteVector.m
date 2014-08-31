function errors = readVoteVector(p)
    
    fid = fopen(p);
    
    dims = fread(fid,2,'int32'); 
    e = fread(fid,[dims(2) dims(1)],'float');
    errors = cell(1,dims(1));
    
    for i=1:dims(1)
        errors{i} = e(:,i)';
    end
    
    while(~feof(fid))
       dims = fread(fid,2,'int32'); 
       if(~feof(fid))
            e = fread(fid,[dims(2) dims(1)],'float');

            for i=1:dims(1)
                errors{i} = [errors{i}; e(:,i)'];
            end
       end
    end
    
    fclose(fid);

end