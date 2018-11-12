% CIRCLEAREA  Find approximate area of unit circle using midpoint rule on a
% a quarter circle.  Run like this:
%   >> circlearea
%   N =    2 estimate:  A = 3.2593673
%   N =    8 estimate:  A = 3.1566869
%   N =   32 estimate:  A = 3.1434914
%   N =  128 estimate:  A = 3.1418304
%   N =  512 estimate:  A = 3.1416224
%   N = 2048 estimate:  A = 3.1415964
%   N = 8192 estimate:  A = 3.1415931

for N = [2 8 32 128 512 2048 8192]
    dx = 1 / N;                % width of rectangles
    x = dx/2:dx:1-(dx/2);      % midpoints of rectangles
    y = sqrt(1 - x.^2);        % heights at midpoints (from quarter circle)
    A = 4 * sum(y) * dx;       % area estimate
    fprintf('N = %4d estimate:  A = %.7f\n',N,A)
end

