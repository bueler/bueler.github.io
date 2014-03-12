function [x, Y] = exer3safe(J,f)
% EXER3SAFE  Solve this ODE BVP by finite differences:
%   y'' + sin(5 x) y = f(x),  y(0)=0, y(1) = 0.
% Example 1: exercise 3
%   >> f = @(x) x.^3 - x;
%   >> [x,y] = exer3safe(10,f);  plot(x,y,'-o')
% Example 2: manufactured problem with known exact solution
%   >> g = @(x) sin(pi*x) .* (sin(5*x) - pi*pi);
%   >> [x,v] = exer3safe(10,g);
%   >> xf = 0:0.001:1;  vexactf = sin(pi*xf);
%   >> plot(x,v,'-o',xf,vexactf)

dx = 1/J;  x = (0:dx:1)';
b = zeros(J+1,1);
b(2:J) = dx^2 * f(x(2:J));
A = sparse(J+1,J+1);
A(1,1) = 1.0;
for j=2:J
  A(j,[j-1, j, j+1]) = [1, - 2 + dx^2 * sin(5 * x(j)), 1];
end
A(J+1,J+1) = 1.0;

Y = A \ b;   % solve A Y = b
