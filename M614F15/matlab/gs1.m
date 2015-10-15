function z = gs1(A,b,x0,N)
% GS1  Do N steps of Gauss-Seidel iteration.  Implemented using Matlab
% tools including backslash.
% Usage:
%   >> z = gs1(A,b,x0,N)

DL = tril(A);    % A = (D+L) + U;  DL includes diagonal
U = triu(A,1);   % super-diagonal

z = x0;
for k = 1:N
  z = DL \ (b - U * z);
end
