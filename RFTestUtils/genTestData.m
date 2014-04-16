function genTestData( outdir )
%GENTESTDATA Summary of this function goes here
%   Detailed explanation goes here

%x == 2 dim, y == 1 dim
    fx = 591.04;
    fy = 594.21;
    cx = 242.74+1;
    cy = 339.30+1;
    C = CCamera([fx 0 cx; 0 fy cy; 0 0 1]);
    
    %height, width
    imsize = [640 480];
    
    fid = fopen([outdir 'files.txt'],'w');
    
    fprintf(fid,',a,a,a\n');
    
    for i=1:10
    
        I = zeros(imsize);
    
        vote = [randi(imsize(1),1) randi(imsize(2),1) randi(500,1)+600];
        vote
        I(vote(2),vote(1)) = vote(3);
        vote3D = C.proj2PC(I);
        
        imwrite(uint16(I),[outdir 'img_' num2str(i) '.png']);
        fprintf(fid,[outdir 'img_' num2str(i) '.png']);
        fprintf(fid,',%04.2f,%04.2f,%04.2f\n',vote3D);
        
    end
    
    fclose(fid);

end

