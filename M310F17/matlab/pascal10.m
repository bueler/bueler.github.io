% PASCAL  Calls COMBIN to generate 10 rows of Pascal's triangle.

for X = 1:10
    for Y = 0:X
        fprintf('%d ',combin(X,Y))
    end
    fprintf('\n')
end
