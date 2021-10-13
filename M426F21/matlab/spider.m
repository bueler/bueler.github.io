function spider(g,x0)
% SPIDER  Produce a "spider-web" plot of a fixed-point iteration
%     x_k+1 = g(x_k),   x_0=x0
% Example:  >> g = @(x) cos(x)
%           >> spider(g,1.0)

% plot iterations in red/green
x = x0;  y = g(x);
for k = 1:6
    plot([x y], [y y], 'r'); hold on
    x = y;  y = g(x);
    plot([x x], [x y], 'g');
end

% plot y=g(x) and y=x
axis tight,  xx = xlim;
zz = linspace(xx(1), xx(2), 301);
plot(zz, g(zz), 'b')
plot(xx,xx,'k')
hold off,  axis tight
title('fixed point?: y=g(x) in blue, y=x in black')
