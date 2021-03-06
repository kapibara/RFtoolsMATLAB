function visualize_VotesStatsT( stats )

    vslength = length(stats.elems);
    rnum = floor(sqrt(vslength));
    cnum = floor(vslength/rnum)+1;
    dim =size(stats.elems{1}.votes,1);
    
    
    if (dim < 3)
        if(~isfield(stats,'map'))
            Ims = cell(length(stats.elems),1);
            centers = cell(length(stats.elems),1);
            for i=1:length(stats.elems)
                    [Ims{i},centers{i}] = aggregateVotes(stats.elems{i}.votes);
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
    elseif dim ==3
       
        for i=1:vslength

            subplot(rnum,cnum,i)
            if (size(stats.elems{i}.votes,2) < 30000)
                scatter3(stats.elems{i}.votes(1,:),stats.elems{i}.votes(2,:),stats.elems{i}.votes(3,:),10);
            else
                sub = ceil(size(stats.elems{i}.votes,2)/30000);
                scatter3(stats.elems{i}.votes(1,1:sub:end),stats.elems{i}.votes(2,1:sub:end),stats.elems{i}.votes(3,1:sub:end),10);
            end
            title(['votes: ' num2str(i) ' size: ' num2str(stats.elems{i}.vc)]);
        end
        
    end
end

