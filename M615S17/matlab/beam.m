function [x, U] = beam(m,verif,f,alpha,beta)
% BEAM Solve 4th-order ODEBVP beam problem on in-class Project A.
% Usage:
%   [x,U] = beam(m,verif,f,alpha,beta)
% Example (verification case):
%   >> [x,U] = beam(10,true);
%   >> plot(x,U)

if (nargin < 3),  f = @(x) x;  end
if (nargin < 4),  alpha = 0.0;  end
if (nargin < 5),  beta = 1.0;  end

h = 1.0 / (m+1);   % m+1 subintervals on [0,1]
x = (h:h:1.0-h)';  % m grid points in column; does not include endpoints 0,1
if m < 5, error('grid must have at least m=5 for this method'); end

printf('assembling linear system  A U = F ...\n')
A = zeros(m,m);   % or do:  A = sparse(m,m);
A(1,[1, 2, 3])            = [7, -4, 1];
A(2,[1, 2, 3, 4])         = [-4, 6, -4, 1];
A(m-1,[m-3, m-2, m-1, m]) = [1, -4, 6, -4];
A(m,[m-2, m-1, m])        = [1, -4, 7];
for j = 3:m-2
    A(j,[j-2, j-1, j, j+1, j+2]) = [1, -4, 6, -4, 1];
end
F = h^4 * f(x);
F(1)   = F(1) + 4 * alpha;
F(2)   = F(2) - alpha;
F(m-1) = F(m-1) - beta;
F(m)   = F(m) + 4 * beta;

printf('solving linear system (cond(A) = %.2e) ...\n',cond(A))
U = A \ F;

if (verif)
    uexact = (1.0/120.0) * x.^5 - (81.0/40.0) * x.^3 + (181.0/60.0) * x.^2;
    printf('error norm = %e\n',norm(U - uexact,'inf'));
end
