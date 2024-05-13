function y= generateCharacter(charSize)
    y = [];
    for i= 1:charSize
        y = [y round(rand)];
    end
end