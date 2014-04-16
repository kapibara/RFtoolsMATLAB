% Check now Hough file for an image will look like

function V = imageToHough(ffile,imgidx)
    fid = fopen(ffile);  
    
    idx = 1;
    l = fgetl(fid);
    while(~feof(fid) && idx~=imgidx)
        l = fgetl(fid);
        idx = idx+1;
    end
    
	toks = {};
	rem = l;
	while(~isempty(rem))
        [tok,rem] = strtok(rem,',');
        toks{end+1} =  tok;
    end
	I = imread(toks{1});
	I = double(I);
	votes = toks(2:end);
	x = cellfun(@(x) str2num(x), votes(1:2:end));
	y = cellfun(@(x) str2num(x), votes(2:2:end));
    
    V = cell(length(x),1);
    for i=1:length(x)
        V{i} = zeros(320,320);
    end
    
	[X,Y] = meshgrid(1:size(I,2),1:size(I,1));
	p = [X(:) Y(:) I(:)];
	p(p(:,3) == 0,:) = [];
    p = p(:,1:2);
    center = [160 160];
    
    for i=1:length(x)
       v = p + repmat(-[x(i) y(i)]+center,size(p,1),1);
       V{i}(sub2ind(size(V{i}),v(:,1),v(:,2))) = V{i}(sub2ind(size(V{i}),v(:,1),v(:,2)))+1;
    end
    
end
