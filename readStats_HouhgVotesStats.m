function hstats = readStats_HouhgVotesStats( fid )
%READSTATS_HOUHGVOTESSTATS Summary of this function goes here
%   Detailed explanation goes here
    hstats.outOfBoundaries = fread(fid,1,'uint32');
    hstats.cols = fread(fid,1,'int32');
    hstats.rows = fread(fid,1,'int32');
    
    hstats.m = fread(fid,[hstats.cols hstats.rows],'uint32');

end

