function [z1, z2] = finitediff(f,x,h)
% FINITEDIFF  Use one-sided O(h^1) and centered O(h^2) finite difference
% formulas to approximate the first derivative of f(x) at x:
%        f(x+h) - f(x)         f(x+h) - f(x-h)
%   z1 = ------------- ,  z2 = ---------------
%              h                     2 h
% Example:
%   >> [z1, z2] = finitediff(@(x) sqrt(x+1),1,1/4)

if nargin < 3  % if user does not give h, use "expert advice" to choose it
    if x == 0
        h = sqrt(eps);
    else
        h = abs(x) * sqrt(eps);
    end
end

z1 = (f(x+h) - f(x)) / h;
z2 = (f(x+h) - f(x-h)) / (2*h);
