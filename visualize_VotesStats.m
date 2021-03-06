function visualize_VotesStats( stats )

    vslength = length(stats.votes);
    rnum = floor(sqrt(vslength));
    cnum = floor(vslength/rnum)+1;
    
    if(~isfield(stats,'map'))
        [Ims,centers] = aggregate_VotesStats(stats);
    else
        Ims = stats.map;
        centers = stats.centers;
    end
    
    for i=1:vslength
        
        
    
        subplot(rnum,cnum,i)
        if size(Ims{i},1) > 1 && size(Ims{i},2) > 1
            imshow(Ims{i}/max(max(Ims{i})))
        else
            bar(Ims{i});
        end
        title(['votes: ' num2str(i) '; x_0:' num2str(centers{i}(1)) ...
                                    '; y_0:' num2str(centers{i}(2)) ...
                                    '; w: ' num2str(size(Ims{i},2)) ...
                                    '; h: ' num2str(size(Ims{i},1))]);
    end
end

