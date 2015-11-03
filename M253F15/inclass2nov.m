% INCLASS2NOV  Show mid-point rule approximation of integral
%   / 1 / 2
%   |   |   sqrt(4 - x^2) sqrt(1 - y^2)  dx dy
%   /-1 /-2
% using m=2 and n=2.

% input f(x,y) as anonymous function that computes correctly with lists
% of numbers as inputs
f = @(x,y) sqrt(4-x.^2).*sqrt(1-y.^2)

% get four midpoint values
f11 = f(-1,-.5)
f12 = f(1,-.5)
f21 = f(-1,.5)
f22 = f(1,.5)

% this is the approximation of the integral because
%    delta A = (delta x) (delta y) = (2) (1) = 2
(f11 + f12 + f21 + f22) * 2

% also, show surface
figure(1)
[x,y] = meshgrid(-2:.01:2, -1:.01:1);
% see that x is big array of x-values of locations:  size(x)
mesh(x,y,f(x,y))
axis equal

% FOLLOWING WAS NOT DONE IN CLASS
% get m = 20 and n = 10 midpoint approximation
dx = .1;
dy = .1;
[xx,yy] = meshgrid(-1.95:dx:1.95, -.95:dy:.95);
dA = dx * dy;
% here is approximation:
sum(sum(f(xx,yy))) * dA
% here is exact integral:
pi^2

