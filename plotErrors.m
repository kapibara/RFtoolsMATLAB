function plotErrors(errors, comp)
    
    hold on
    p =  gen_palette(length(errors));
%    uvlimits = {};
%    depth = {};
    folder = {};
    
    for i=1:length(errors)
        plot(errors{i}.trimg,errors{i}.tre(:,comp),':','Color',p(i,:),'LineWidth',1.5);
        plot(errors{i}.teimg,errors{i}.tee(:,comp),'--','Color',p(i,:),'LineWidth',1.5);
        plot(errors{i}.img,errors{i}.e(:,comp),'-','Color',p(i,:),'LineWidth',1.5);
%        uvlimits = [uvlimits; num2str(errors{i}.uvlimit); num2str(errors{i}.uvlimit); num2str(errors{i}.uvlimit)];
%        depth = [depth; num2str(errors{i}.depth); num2str(errors{i}.depth); num2str(errors{i}.depth)];
        folder = [folder; errors{i}.range; errors{i}.range; errors{i}.range];
    end
    
%    legend(uvlimits);
%    legend(depth);
    legend(folder);
end