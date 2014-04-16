function writeStats_VotesStats(fid,stats)
    fwrite(fid,stats.point_count,'uint32');
    fwrite(fid,stats.vclasses,'uint8');
    for i=1:stats.vclasses
        fwrite(fid,size(stats.votes{i},2),'uint32');
        fwrite(fid,stats.votes{i},'int32');
    end
    
    if(isfield(stats,'map'))
        fwrite(fid,length(stats.map),'uint8');
        for i=1:length(stats.map)
            m = stats.map{i};
            fwrite(fid,size(m,1),'uint16');
            fwrite(fid,size(m,2),'uint16');
            m = m';
            fwrite(fid,m(:),'uint16');
            fwrite(fid,stats.centers{i}(1),'int32');
            fwrite(fid,stats.centers{i}(2),'int32');
        end
    else
        fwrite(fid,0,'uint8');
    end
end