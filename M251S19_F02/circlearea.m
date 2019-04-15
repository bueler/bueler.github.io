% CIRCLEAREA  Find approximate area of unit circle using right endpoint rule on
% the quarter circle.  Run like this:
% >> circlearea
% N =        2 estimate:  A = 1.7320508
% N =       10 estimate:  A = 2.9045183
% N =      100 estimate:  A = 3.1204170
% N =     1000 estimate:  A = 3.1395555
% N =    10000 estimate:  A = 3.1413915
% N =   100000 estimate:  A = 3.1415726
% N =  1000000 estimate:  A = 3.1415907
% N = 10000000 estimate:  A = 3.1415925

for N = [2 10 100 1000 10000 100000 1000000 10000000]
    dx = 1 / N;                % width of rectangles
    x = dx:dx:1;               % midpoints of rectangles
    y = sqrt(1 - x.^2);        % heights at midpoints (from quarter circle)
    A = 4 * sum(y) * dx;       % area estimate
    fprintf('N = %8d estimate:  A = %.7f\n',N,A)
end

