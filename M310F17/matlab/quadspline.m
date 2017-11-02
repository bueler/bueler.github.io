function [a, b, c] = quadspline(x,y)
% QUADSPLINE  Construct a quadratic spline through the data (x,y).
% On each interval [x(k),x(k+1)] the quadratic polynomial has form
%     p(z) = a(k) + b(k) (z - x(k)) + c(k) (z - x(k)) (z - x(k+1)).
% Plot the spline with PLOTQS.
% Example:
%     x = [0 0.5 1 1.3 1.7 2];
%     y = sin(x.^2);
%     [a, b, c] = quadspline(x,y);
%     plotqs(x,y,a,b,c)
%     xx = 0:.01:2;
%     hold on,  plot(xx,sin(xx.^2),'g'),  hold off

if length(x) ~= length(y)
    error('data x,y must be vectors of equal length')
end
n = length(x) - 1;   % = number of subintervals
a = zeros(1,n);
b = a;
for k = 1:n
    a(k) = y(k);
    b(k) = (y(k+1) - y(k)) / (x(k+1) - x(k));
end
c = zeros(1,n);   % so c(1)=0
for k = 2:n
    c(k) = ( b(k) - b(k-1) - (x(k) - x(k-1))*c(k-1) ) / (x(k+1) - x(k));
end

