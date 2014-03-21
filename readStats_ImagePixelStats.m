function h = readStats_ImagePixelStats(fid)
    s = fread(fid,1,'uint32');
    
    pixels = zeros(s,5);
    
    for i=1:s
        pixels(i,1) = fread(fid,1,'int32');
        pixels(i,2) = fread(fid,1,'int32');
        pixels(i,3:5) = readStats_ClassStats(fid);
    end
    
    h.pixels = pixels;
    
%     minx = min(pixels(:,1));
%     miny = min(pixels(:,2));
%     
%     maxx = max(pixels(:,1));
%     maxy = max(pixels(:,2));    
%     
%     pixels(:,1) = pixels(:,1) - minx +1;
%     pixels(:,2) = pixels(:,2) - miny +1;
%     
% 
%     
%     mask = zeros(maxx-minx+1,maxy-miny+1,3);
%     cmap = colormap(lines);
%     
%     cl = max(pixels(:,3));
%     code = zeros(cl+1,3);
%     
%     for i=0:cl
%         idx = find(pixels(:,3) == i);
%         code(i+1,:) = cmap(i+1,:);
%         for j=0:2
%             mask(j*size(mask,1)*size(mask,2)+sub2ind([size(mask,1) size(mask,2)], pixels(idx,1), pixels(idx,2))) = cmap(i+1,j+1);
%         end
%     end
%     
%     h.pixels = pixels;
%     h.mask = mask;
%     h.code = code;
    
end