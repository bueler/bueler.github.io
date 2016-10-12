function [f, df] = cable(x,n,C);
% CABLE Objective function associated to a problem of the minimum energy of
% a hanging cable.  An understandable example of where we want the dimension
% of the input x is as large as possible.
%
% Usage:      [f, df] = cable(x,n,C)
% where
%     f  = function value (elastic plus potential energy of cable)
%     df = gradient of f
%     x  = vector of length n (displacements)
%     n  = dimension of problem (number of interior points along cable)
%     C  = constant (weight per unit length of cable)
%
% Example:
%   >> x = [-1 -2 -1]';
%   >> [f, df] = cable(x,3,1)
% Example where we use CABLE in optimization code SDBT:
%   >> x0 = [-1 -2 -1]';
%   >> f = @(x) cable(x,3,1);
%   >> f(x0)                    % check this makes sense
%   >> [xk, xklist, alphaklist] = sdbt(x0,f,1.0e-4)

x = x(:);   % force into column
if length(x) ~= n,  error('input x must be of dimension n');  end

% function value
h = 1.0 / (n+1);    % subinterval length
f = x(1)^2 + x(n)^2;
for j = 1:n-1
    f = f + (x(j+1) - x(j))^2;
end
f = h * ( (0.5 / h^2) * f + C * sum(x) );

% gradient
df = zeros(size(x));
df(1) = (1.0 / h^2) * (2.0 * x(1) - x(2)) + C;
for j = 2:n-1
    df(j) = (1.0 / h^2) * ( 2.0 * x(j) - x(j-1) - x(j+1) ) + C;
end
df(n) = (1.0 / h^2) * (2.0 * x(n) - x(n-1)) + C;
df = h * df;
