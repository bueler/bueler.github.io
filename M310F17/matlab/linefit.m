function [m, b] = leastsquaresline(x,y)
% LEAST ...  FIXME

if length(x) ~= length(y)
    error('data must be same length')
end
n = length(x);

A = [sum(x.^2), sum(x);
     sum(x),         n];
r = [sum(y.*x); sum(y)];
v = A \ r;
m = v(1);
b = v(2);
