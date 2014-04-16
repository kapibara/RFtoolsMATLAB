function [P,k,Rel,s]=readCal(fname)
    caldata = importdata(fname);
    
    P = caldata(1:3,1:3);
    k = [caldata(4,1:3) caldata(5,1)];
    Rel = [caldata(6:8,1:3) caldata(9,1:3)'];
    s = caldata(10,1:2);
end