function visualize_ImagePixelStats(stats)

    subplot(1,2,1)
    imshow(stats.mask)
    subplot(1,2,2)
    scatter(ones(size(stats.code,1),1),0:size(stats.code,1)-1,100,stats.code,'fill')
    xlim([0.8 1.2])
    ylim([-0.1 size(stats.code,1)-1+0.1])
    pos = get(gca,'Position');
    set(gca,'Position',[pos(1)+pos(3)-0.2 pos(2) 0.2 pos(4)])
end