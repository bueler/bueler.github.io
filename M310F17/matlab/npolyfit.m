function a = npolyfit(x,y,n)
% NPOLYFIT   For data in arrays x and y, construct the n degree polynomial
% interpolant in the Newton form
%     p(x) = a(1) + a(2) (x-x(1)) + a(3) (x-x(1)) (x-x(2)) + ...
%            + a(n+1) (x-x(1)) (x-x(2)) ... (x-x(n))
% which interpolates the points (x(j),y(j)).
% Example:
%     x = 0:4;
%     y = rand(1,5);
%     a = npolyfit(x,y,4);
%     xx = 0:.01:4;
%     plot(x,y,'o',xx,npolyval(a,x,xx))
% See NPOLYVAL and TESTNPOLY.  Compare POLYFIT and POLYVAL.

if (length(x) ~= length(y) || length(x) < n+1)
    error('data x,y must be vectors of equal length at least n+1')
end
a = zeros(1,n+1);
a(1) = y(1);
for k = 2:n+1
    w = 1;
    p = 0;
    for j = 1:k-1
        p = p + a(j) * w;
        w = w * (x(k) - x(j));
    end
    a(k) = (y(k) - p) / w;
end
