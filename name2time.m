function time = name2time(folder)
    result = regexp(folder,'^(\d){1,2}_(\d){1,2}_(\d){1,2}_(\d){1,2}','tokens');
    time = cellfun(@(x) str2double(x),result{1});
end