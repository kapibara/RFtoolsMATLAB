function h = drawNode(node,t,options)
    biographScale = node.up.Scale;
    id = str2double(get(node,'ID'));
    
    x = node.Position(1)*biographScale;
    y = node.Position(2)*biographScale;
    
    haxes = node.up.hgAxes;
    
    rx = node.Size(1);
    ry = node.Size(2);
    
    elemCount = options.elemCount(t.nodes(id).stats);
    scale = log(elemCount)/10;
    
    if(scale>0)
    
        h(1) = rectangle('Position',[x-rx*scale/2,y-ry*scale/2,rx*scale,ry*scale],'Curvature',[1,1],'FaceColor','r','Parent',haxes);
        
        
    else
        
        scale = 0.5;
        h(1) = rectangle('Position',[x-rx*scale/2,y-ry*scale/2,rx*scale,ry*scale],'Curvature',[1,1],'FaceColor','k','Parent',haxes);
    end
    
    h(2) = text(x+rx/2,y-ry/2,num2str(elemCount),'Parent',haxes);

end