function visualize_VotesStatsT( stats )

    vslength = stats.pc;
    rnum = floor(sqrt(vslength));
    cnum = floor(vslength/rnum)+1;
    
    if(~isfield(stats,'map'))
        Ims = cell(length(stats.elems),1);
        centers = cell(length(stats.elems),1);
        for i=1:length(stats.elems)
            [Ims{i},centers{i}] = aggregateVotes(stats);
        end
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

