% the following function if given the array [1 0 1] and k =3
% will generate the output [1 1 1 0 0 0 1 1 1]
% you can view this as basic source encoding 
function y = generateMultiple(array, k)
    y = [];
    for i = 1:length(array)
        for j = 1:k
            y = [y array(i)];
        end
    end
end