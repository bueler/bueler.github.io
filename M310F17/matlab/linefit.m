function [m, b] = linefit(x,y)
% LINEFIT  Do least squares fitting (regression) of a line  y = m x + b
% to data x and y.  Here x and y are arrays of the same length.
% Does the same thing as POLYFIT.
% Example:  Generate data which is near a line, and find the line.
%     x = rand(1,10);
%     y = 1.2 - 2.3 * x + 0.3 * randn(1,10);
%     [m, b] = linefit(x,y)                   % same as:  p = polyfit(x,y,1)
%     xx = 0:.01:1;
%     plot(x,y,'ko',xx,m*xx+b)

if length(x) ~= length(y)
    error('data must be same length')
end
n = length(x);
A = [sum(x.^2), sum(x);
     sum(x),         n];
r = [sum(y.*x); sum(y)];
v = A \ r;                 % solve linear system   A v = r
m = v(1);
b = v(2);
