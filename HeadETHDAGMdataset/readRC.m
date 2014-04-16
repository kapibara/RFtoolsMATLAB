function [C,R]=readRC(fname)
    rc = importdata(fname);
    
    R = rc(1:3,1:3);
    C = rc(4,1:3);
end