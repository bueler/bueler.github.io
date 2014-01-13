function [A,b] = assemble(N)
% ASSEMBLE a linear system  A x = b of size  m x m  (where m = N-1)
% for a boundary value problem.

L = 3.0;  k = 1.0;  f = @(x) exp(- 20 * (x - 2).^2);
m = N - 1;
x = linspace(0,L,N+1);
dx = (L - 0) / N;

A = sparse(m,m);            % sparse storage speeds big m cases
b = zeros(m,1);
for i = 1:m                 % build row i of A and b
  if i > 1
    A(i,i-1) = k;
  end
  if i < m
    A(i,i+1) = k;
  end
  A(i,i) = - 2.0 * k;
  b(i) = - dx * dx * f(x(i+1));
end
