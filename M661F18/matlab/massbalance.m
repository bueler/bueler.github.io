% MASSBALANCE  Generate mass balance figure for problem GLACIER.

x = linspace(-100,100,201);
x0 = x(x <= -70);
x1 = x(x >= -70 & x <= 20);
x2 = x(x >= 20 & x <= 70);
x3 = x(x >= 70);
y1 = -3 + (6/90) * (x1 + 70);
y2 =  3 - (6/50) * (x2 - 20);

plot(x1,y1,'k');
hold on
plot(x2,y2,'k');
plot(x0,-3*ones(size(x0)),'k');
plot(x3,-3*ones(size(x3)),'k');
hold off

grid on
xlabel('x  (km)','fontsize',20.0)
ylabel('m(x)  (meters per year)','fontsize',20.0)

print -dpdf massbalance.pdf

