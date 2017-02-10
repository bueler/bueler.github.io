function [x, U] = tube(m,verif,v,f)
% TUBE Solve 2nd-order periodic ODE problem on in-class Project B.
% Usage:
%   [x,U] = tube(m,verif,v,f)
% Example (verification case):
%   >> [x,U] = tube(10,true);
%   >> plot(x,U)

if (nargin < 3),  v = @(x) 30.0 * (1.0 + sin(x));  end
% default f(x) is for manufactured exact soln  u(x) = cos(3 x)
if (nargin < 4),  f = @(x) 4.0 * cos(3.0 * x) - 3.0 * v(x) .* sin(3.0 * x);  end

h = 2.0 * pi / m;   % m subintervals on (0,2 pi]
x = (h:h:2.0*pi)';  % m grid points in column; interpret periodically
if m < 3, error('grid must have at least m=3 for this method'); end

printf('assembling linear system  A U = F ...\n')
A = (-2.0 + 5 * h^2) * eye(m,m);   % diagonal; also  A = ... speye(m,m);
for j = 1:m    % fill off-diagonal entries
    entries = [1.0 + (h/2.0) * v(x(j)), 1.0 - (h/2.0) * v(x(j))];
    if j == 1
        A(j,[m, 2]) = entries;
    elseif j == m
        A(j,[m-1, 1]) = entries;
    else
        A(j,[j-1, j+1]) = entries;
    end
end
F = - h^2 * f(x);

printf('solving linear system (cond(A) = %.2e) ...\n',cond(A))
U = A \ F;

if (verif)
    uexact = cos(3.0 * x);
    printf('error norm = %e\n',norm(U - uexact,'inf'));
end
