%% display images

figure(1)

p = '/home/kuznetso/tmp/CubeExperiment/Cube_grouped/g0_1_2/';
files = dir([p 'cube46*.png']);
fnames = arrayfun(@(x) x.name,files,'UniformOutput',false);

for i=1:length(fnames)
    
    I = imread([p fnames{i}]);
    I = double(I);
    
    if(sum(sum(I)) == 0)
        warning('empty image');
    end
    
    I = I/max(max(I));
    
    imshow(I);
    title(fnames{i})

    pause
    
end

p = '/home/kuznetso/tmp/CubeExperiment/Cube_grouped/g0_2_2/';
files = dir([p 'cube46*.png']);
fnames = arrayfun(@(x) x.name,files,'UniformOutput',false);

for i=1:length(fnames)
    
    I = imread([p fnames{i}]);
    I = double(I);
    
    if(sum(sum(I)) == 0)
        warning('empty image');
    end
    
    I = I/max(max(I));
    
    imshow(I);
    title(fnames{i})

    pause
    
end

p = '/home/kuznetso/tmp/CubeExperiment/Cube_grouped/g0_3_2/';
files = dir([p 'cube46*.png']);
fnames = arrayfun(@(x) x.name,files,'UniformOutput',false);

for i=1:length(fnames)
    
    I = imread([p fnames{i}]);
    I = double(I);
    
    if(sum(sum(I)) == 0)
        warning('empty image');
    end
    
    I = I/max(max(I));
    
    imshow(I);
    title(fnames{i})

    pause
    
end