function hstats = readStats_HoughVotesStats( fid )
%READSTATS_HOUHGVOTESSTATS Summary of this function goes here
%   Detailed explanation goes here
    hstats.outOfBoundaries = fread(fid,1,'uint32');
    hstats.gt_x = fread(fid,1,'int32')+1;%convert to matlab coordinate system
    hstats.gt_y = fread(fid,1,'int32')+1;%convert to matlab coordinate system
    hstats.cols = fread(fid,1,'uint32');
    hstats.rows = fread(fid,1,'uint32');
    hstats.center_x = fread(fid,1,'int32')+1;
    hstats.center_y = fread(fid,1,'int32')+1;
    
    hstats.m = fread(fid,[hstats.cols hstats.rows],'double');

end

