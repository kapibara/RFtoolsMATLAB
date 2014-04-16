function [errors, votesAsMat, gtAsMat, img] = errorStats(p,suffix)

    if(~exist('suffix','var'))
        suffix = '_test';
    end
    
    files = dir(p);
    goodFiles = arrayfun(@(x) regexp(x.name,['(\d){1,}_(\d){1,2}' suffix '$'],'tokens'),files,'UniformOutput',false);
    isgood = cellfun(@(x) ~isempty(x),goodFiles);
    goodFiles = goodFiles(isgood);
    imnumber = cellfun(@(x) str2num(x{1}{1}),goodFiles);
    jointnumber = cellfun(@(x) str2num(x{1}{2}),goodFiles);
    
    imnumber = unique(imnumber);
    jointnumber = unique(jointnumber);
    
    errors = zeros(length(imnumber),length(jointnumber));
    
    img = zeros(length(imnumber),1);
    
    votesAsMat = zeros(length(imnumber),2*length(jointnumber));
    gtAsMat = zeros(length(imnumber),2*length(jointnumber));
    
    for i=1:length(imnumber)
        for j=1:length(jointnumber)
            
            fname = [p 'img_' num2str(imnumber(i)) '_' num2str(jointnumber(j)) suffix];
            
            fid = fopen(fname);
            hstats = readStats_HoughVotesStats( fid );
            fclose(fid);
            
            %maximum -> potential joint location
            [x_p,y_p]=find(hstats.m==max(max(hstats.m)));
            x_p = x_p(end);
            y_p = y_p(end);
            
            votesAsMat(i,[2*j-1,2*j]) = [x_p-hstats.center_x,y_p-hstats.center_y];
            gtAsMat(i,[2*j-1,2*j]) = [hstats.gt_x hstats.gt_y];
            
            e = [y_p(end)-hstats.center_y x_p(end)-hstats.center_x] - [hstats.gt_y hstats.gt_x];
            e = sqrt(sum(e.^2));
            
            errors(i,j) = e;
            img(i) = imnumber(i);
            
        end
    end
    
    
end