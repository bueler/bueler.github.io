function [A,x,y,UU] = fishy(m,useGS,p,q,f)
% FISHY  Solve the Poisson-like equation
%   u_xx + u_yy + p u_x + q u = f(x,y)
% on the unit square, with zero Dirichlet boundary conditions.  Here p,q are
% real numbers, so the problem is constant-coefficient.  The grid has h = 1 / (m+1).
% Usage:   [A,x,y,UU] = fishy(m,useGS,p,q,f)
% Example of verification case (prints the error norm):
%   >> fishy(10);
% Examine A in a 3x3 grid case with big p=100:
%   >> A = fishy(3,false,100);  full(A)
% Same case using Gauss-Seidel, and it fails:
%   >> A = fishy(3,true,100);
% Plot solution in a verification case:
%   >> [A,x,y,UU] = fishy(40);  surf(x,y,UU)

if nargin < 5
    % generate RHS in verification case (manufactured)
    pp = 2.0;  qq = 1.0;  Lx = 5.0 * pi;  Ly = 3.0 * pi;
    uexact = @(x,y) sin(Lx * x) .* sin(Ly * y);
    f = @(x,y) (- Lx^2 - Ly^2 + qq) * uexact(x,y) ...
               + pp * Lx * cos(Lx * x) .* sin(Ly * y);
end
if nargin < 4,  q = 1.0;  end
if nargin < 3,  p = 2.0;  end
if nargin < 2,  useGS = false;  end

% assemble system
h = 1.0 / (m+1);  x = linspace(h,1.0-h,m);  y = x;   % grid
kk = @(i,j) (j-1) * m + i;                           % local-to-global index
N = m^2;  A = sparse(N,N);  F = zeros(N,1);
for i = 1:m
    for j = 1:m
       k = kk(i,j);
       A(k,k) = - 4.0 + h^2 * q;
       if i > 1,    A(k,kk(i-1,j)) = 1.0 - p * h / 2.0;    end
       if i < m,    A(k,kk(i+1,j)) = 1.0 + p * h / 2.0;    end
       if j > 1,    A(k,kk(i,j-1)) = 1.0;    end
       if j < m,    A(k,kk(i,j+1)) = 1.0;    end
       F(k) = f(x(i),y(j));
    end
end
A = (1.0 / h^2) * A;

% solve by chosen algorithm
if (useGS)
    printf('[starting Gauss-Seidel]\n')
    [U,N] = gsTOL(A,F,zeros(size(F)),1.0e-8);
    if N < 0,  error('Gauss-Seidel method failed to converge'),  end
    printf('[Gauss-Seidel did %d iterations]\n',N)
else
    U = A \ F;
end
UU = reshape(U,m,m);  % put U back on grid for output

% compute error in verification case
if nargin < 3
    [xx, yy] = ndgrid(x,y);
    UEX = reshape(uexact(xx,yy),N,1);
    printf('error on %d x %d grid with h = %.4f:  |U-Uexact|_inf = %.3e\n',...
           m,m,h,norm(U-UEX,'inf'));
end
end % function fishy
