function [x,y,UU,errnorm,A] = poisson(m,f)
% POISSON  Solve the Poisson equation
%   u_xx + u_yy = f(x,y)
% on the unit square, with zero Dirichlet boundary conditions (u=0 on boundary).
% Usage:   [x,y,UU,errnorm,A] = poisson(m,f)
% Example of verification case:
%   >> [x,y,U,errnorm] = poisson(10);
% Example with general right-hand-side and surface plot:
%   >> f = @(x,y) exp(-30.0*((x-0.5).^2 + (y-0.75).^2));
%   >> [x,y,U] = poisson(100,f);
%   >> surf(x,y,U), xlabel x, ylabel y
% Example where you show sparsity pattern of A:
%   >> [x,y,U,errnorm,A] = poisson(5);  spy(A)

% RHS in verification case (manufactured; see uexact() later)
if (nargin < 2),  f = @(x,y) 12.0 .* (x.^2 .* (y.^4 - y) + (x.^4 - x) .* y.^2);  end

h = 1.0 / (m+1);  x = linspace(h,1.0-h,m);  y = x;   % grid

% assemble system
kk = @(i,j) (j-1) * m + i;            % local-to-global grid index formula
N = m^2;  A = sparse(N,N);  F = zeros(N,1);
for i = 1:m
    for j = 1:m
       k = kk(i,j);
       A(k,k) = -4.0;
       if i > 1,    A(k,kk(i-1,j)) = 1.0;    end
       if i < m,    A(k,kk(i+1,j)) = 1.0;    end
       if j > 1,    A(k,kk(i,j-1)) = 1.0;    end
       if j < m,    A(k,kk(i,j+1)) = 1.0;    end
       F(k) = f(x(i),y(j));
    end
end
A = (1.0 / h^2) * A;

U = A \ F;                            % solve

UU = zeros(m,m);
for i = 1:m
    for j = 1:m
        UU(i,j) = U(kk(i,j));         % put U on grid for output
    end
end

if (nargin < 2)                       % compute error in verification case
    uexact = @(x,y) (x.^4 - x) .* (y.^4 - y);
    for i = 1:m
        for j = 1:m
            k = kk(i,j);
            U(k) = U(k) - uexact(x(i),y(j));   % use U to store E=U-Uexact
        end
    end
    errnorm = norm(U,'inf');
    printf('error on %d x %d grid with h = %.4f:  |U-Uexact|_inf = %.3e\n',m,m,h,errnorm);
end
end % function poisson
