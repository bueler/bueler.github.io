function [x,y,A,frhs] = passemble(m,f)
% ASSEMBLE  Assemble matrix A and right hand side frhs for Poisson equation
%   u_xx + u_yy = f(x,y)
% on the unit square, with zero Dirichlet boundary conditions (u=0 on boundary).
% Usage:  [x,y,A,frhs] = passemble(m,f)

% grid and indexing
h = 1.0 / (m+1);  x = linspace(h,1.0-h,m);  y = x;
kk = @(i,j) (j-1) * m + i;     % local-to-global grid index formula

% assemble linearization; note  A u = u_xx + u_yy  (approximately)
N = m^2;  A = sparse(N,N);
frhs = zeros(N,1);
for i = 1:m
    for j = 1:m
        k = kk(i,j);
        A(k,k) = -4.0;
        if i > 1,    A(k,kk(i-1,j)) = 1.0;    end
        if i < m,    A(k,kk(i+1,j)) = 1.0;    end
        if j > 1,    A(k,kk(i,j-1)) = 1.0;    end
        if j < m,    A(k,kk(i,j+1)) = 1.0;    end
        frhs(k) = f(x(i),y(j));
    end
end
A = (1.0 / h^2) * A;
