function [x,U] = varheatFD(J)
% Set up and solve, by finite differences, a "serious" linear
% two-point BVP for equilibrium temperature distribution in a rod.
% The terms correspond to variable conductivity, constant
% chemical-reaction-created heat, and variable externally-introduced heat.
% Example:
%   >> [x,u] = varheatFD(60);

L  = 3;
k  = @(x) 0.5 * atan((x-1.0) * 20.0) + 1.0;
s  = @(x) exp(-(x-2.0).^2);
r0 = 0.5;

dx    = L / J;
x     = (0:dx:L)';             % regular grid
xstag = ((dx/2):dx:L-(dx/2))'; % staggered grid
kstag = k(xstag);              % k(x) on staggered grid

% right side is J+1 length column vector
b = [0; 
     - dx^2 * s(x(2:J));
     0];

% matrix is tridiagonal
A = sparse(J+1,J+1);
A(1,[1 2]) = [-1.0 1.0];
for j=1:J-1
  A(j+1,j)   = kstag(j);
  A(j+1,j+1) = - kstag(j) - kstag(j+1) + r0 * dx^2; 
  A(j+1,j+2) = kstag(j+1);
end
A(J+1,J+1) = 1.0;

% uncomment to see pattern of A, a tridiagonal matrix:
%figure(3), spy(A)

% uncomment to see entries of A; unwise if J >> 10:
%full(A)

U = A \ b;       % soln is J+1 column vector

figure(1)
plot(x,k(x),'r',x,s(x),'b',x,U','g*','markersize',3)
grid on,  xlabel x
legend('k(x)','s(x)','solution U_j')
title(sprintf('result of FINITE DIFFERENCES:  u(0) = %.6f',U(1)))

