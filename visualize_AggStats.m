function [rnum,cnum]=visualize_AggStats( stats )

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
            v = stats.elems{i}.votes;
            w = stats.elems{i}.weights;
            
            v(:,w<=0) = [];
            w(w<=0) = [];

            subplot(rnum,cnum,i)
            if (size(v,2) < 30000)
                scatter3(v(1,:),v(2,:),v(3,:),500*w);
            else
                sub = ceil(size(v,2)/30000);
                scatter3(v(1,1:sub:end),v(2,1:sub:end),v(3,1:sub:end),500*w(1:sub:end));
            end
            title(['votes: ' num2str(i) ' size: ' num2str(size(v,2))]);
        end
        
    end
end

