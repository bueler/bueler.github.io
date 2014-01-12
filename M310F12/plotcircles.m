% PLOTCIRCLES  plot intersecting circles and zoom on their intersections

theta = linspace(0,2*pi,1000);
% first circle:
x = 2 + sqrt(2) * cos(theta);
y = 1 + sqrt(2) * sin(theta);
% second circle:
xx = 2.5 + sqrt(3.5) * cos(theta);
yy = 0 + sqrt(3.5) * sin(theta);
plot(x,y,xx,yy)
axis equal
grid on
