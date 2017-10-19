function px = npolyval(a,x,xx)
% NPOLYVAL  Evaluate a Newton-form polynomial using its coefficents a, the
% x-coordinates of its data points x, and points of evaluation xx.
% See NPOLYFIT and TESTNPOLY.  Compare POLYFIT and POLYVAL.

if length(a) ~= length(x)
    error('coefficients a and nodes x must be vectors of the same length')
end
n = length(a) - 1;
px = zeros(size(xx));
px = a(n+1);
for k = n:-1:1
    px = a(k) + px .* (xx - x(k));
end
