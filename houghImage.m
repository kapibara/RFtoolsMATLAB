%Compute Hough statistics given the points and the leaf indices in a tree

function [H,oub,Hcenters] = houghImage(tree, indices, xVals, yVals, zeroCenters, exclude)
    
    if(exist('exclude','var'))
        indices(ismember(indices,exclude)) = -1;
    end
    
    if(~exist('xVals','var'))
        xVals = -1*ones(length(indices),1);
        yVals = -1*ones(length(indices),1);
    end
    
    if(~exist('zeroCenters','var'))
        zeroCenters =  0;
    end

    indices = indices+1; %since we save c++-style indices
    xVals = xVals(indices>0)+1;
    yVals = yVals(indices>0)+1;
    indices = indices(indices>0);
    

    uind = unique(indices);
    
    vslength = length(tree.nodes(uind(1)).stats.map);   
    
    fsdef = [5 5];
    fs = [0 0];
    %aggregate all stats
    if(~isfield(tree.nodes(uind(1)).stats,'map'))
        warning('statistics is not aggregated');
        return
    end
    
    
    w = 480; h = 640;
    
    H = cell(vslength,1);
    oub = cell(vslength,1);
    Hcenters = cell(vslength,1);
    for i=1:vslength
        if(zeroCenters)
            Hcenters{i} = [0 0];
        else
            Hcenters{i} = [w/2+1 h/2+1];
        end
        H{i} = zeros(w,h);    
        oub{i} = 0;
    end 
    
    %create a picture
    %(x,y) - center + img + hcenter
    for i=1:vslength
        sizes = arrayfun(@(x) getSize(x,i) ,tree.nodes, 'UniformOutput',false);
        sizes = cell2mat(sizes)';
        sizes = sizes(indices,:);
        centers = arrayfun(@(x) getCenter(x,i) ,tree.nodes, 'UniformOutput',false);
        centers = cell2mat(centers)';
        centers = centers(indices,:);
        
        startpoint = [xVals yVals] - centers + 1 + repmat(Hcenters{i},length(xVals),1); %(height, width)
        endpoint = [xVals yVals] - centers +  sizes + repmat(Hcenters{i},length(xVals),1);
        
      
        for j = 1:length(xVals)
            if(~isfield(tree.nodes(indices(j)).stats,'map'))
                warning('map field does not exist');
            end
%            if(votesVariance(tree.nodes(indices(j)).stats)<50000000)
                Imsstart = [1 1];
                Imsend = size(tree.nodes(indices(j)).stats.map{i});
                if(startpoint(j,1)<1)
                    Imsstart(1) = Imsstart(1) + 1 - startpoint(j,1);
                    startpoint(j,1) = 1;
                end
                if(startpoint(j,2)<1)
                    Imsstart(2) = Imsstart(2) + 1 - startpoint(j,2);
                    startpoint(j,2) = 1;
                end
                if(endpoint(j,1)>w)
                    Imsend(1) = Imsend(1) - (endpoint(j,1)-w);
                    endpoint(j,1) = w;
                end
                if(endpoint(j,2)>h)
                    Imsend(2) = Imsend(2) - (endpoint(j,2)-h);
                    endpoint(j,2) = h;
                end
                
                H{i}(startpoint(j,1):endpoint(j,1),startpoint(j,2):endpoint(j,2)) = ...
                H{i}(startpoint(j,1):endpoint(j,1),startpoint(j,2):endpoint(j,2)) + ...
                    tree.nodes(indices(j)).stats.map{i}(Imsstart(1):Imsend(1),Imsstart(2):Imsend(2));
                oub{i} =  oub{i} + sum(sum(tree.nodes(indices(j)).stats.map{i})) - ...
                    sum(sum( tree.nodes(indices(j)).stats.map{i}(Imsstart(1):Imsend(1),Imsstart(2):Imsend(2))));
%            end
        end
    end
    
    
end

function s = getSize(x,i)
    if(isfield(x.stats,'map'))
        s = size(x.stats.map{i})';
    else
        s = [0 0]';
    end
end

function c = getCenter(x,i)
    if (isfield(x.stats,'centers')) 
        if(length(x.stats.centers)<i)
            warning('length(x.stats.centers)<i');
        end
        c = x.stats.centers{i};
    else
        c = [0 0]';
    end
end