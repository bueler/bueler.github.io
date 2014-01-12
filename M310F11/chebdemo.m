% CHEBDEMO Show that the product
%   (x - x0) (x - x1) (x - x2) . . . (x - xn)
% is smaller for Chebyshev points on the interval than
% for equally-spaced points.

% equally-spaced point
n = 10;
xj = linspace(-1,1,n+1);
x = linspace(-1,1,1000);
y=ones(size(x));
for j=0:n
  y = y .* (x-xj(j+1));
end

% chebyshev points
xjc = cos(pi*(n-(0:n))/n);
yc = ones(size(x));
for j=0:n
  yc=yc.*(x-xjc(j+1));
end
plot(x, abs(y), x,abs(yc))

% decorate the figure
legend('equally-spaced points','Chebyshev points')
xlabel x, grid on, axis tight

