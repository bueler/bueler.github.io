function [f,df,Hf] = obstaclefcn(u)
% OBSTACLEFCN  Evaluate objective function, gradient, and Hessian for 1D
% obstacle problem.  The continuum objective is the elastic energy functional
%          /L
%   f[u] = |  (1/2) (u'(x))^2 - q(x) u(x) dx
%          /0
% Here L=1 and q(x) = -cos(2*pi*x) - (1/2).  (Note q(x) is only positive in a
% small interval near x=L/2.)  Uses midpoint rule to do the integral
% numerically.  Extracts the number of points from the length of the input u.

L = 1.0;
q = @(x) - cos(2*pi*x) - 0.5;

u = u(:);
n = length(u);
dx = L / (n+1);
x = dx:dx:L-dx;

f = 0;
df = zeros(size(u));  FIXME
for i = 0:n
    if i > 0
        dudx = (u(i+1) - u(i))/dx;
        uav = 0.5 * (u(i) + u(i+1));
    else
        dudx = u(1)/dx;
        uav = u(1)/2;
    end
    xmid = x(i+1) - dx/2;
    f = f + (1/2) * dudx^2 - q(xmid) * uav;
end
f = f * dx;

Hf = zeros(n,n);
FIXME
