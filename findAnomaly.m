function index = findAnomaly(array1, array2)
    index = [];
    if(length(array1) == length(array2))
        for i=1:length(array1)
            if(array1(i) ~= array2(i))
                index = [index i];
            end
        end
    end
end