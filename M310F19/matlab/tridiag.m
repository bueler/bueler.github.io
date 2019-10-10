function x = tridiag(A,b)
% TRIDIAG  Solve a tridiagonal linear system  A x = b using Gauss Elimination
% and back-substitution only where entries are nonzero.  If A is n by n then
% this code does  8n-7 = O(n) operations (versus O(n^3) for general
% Gauss Elimination).
% Example: >> A = tril(triu(randn(5,5),-1),+1);  % is tridiagonal
%          >> b = randn(5,1);
%          >> x = tridiag(A,b)
%          >> norm(A\b - x)

n = length(b);
if size(A,1) ~= n || size(A,2) ~= n
    error('A must be n by n if b has length n')
end

% this is a fancy check that A is tridiagonal
% ... how does it work? ... note it checks O(n^2) locations
[i,j] = find(A);
if any(abs(i-j) > 1)
    error('A is not tridiagonal')
end

% get zeros below diagonal
for j = 2:n
    mult = A(j,j-1) / A(j-1,j-1);
    A(j,j-1) = 0;
    A(j,j) = A(j,j) - mult*A(j-1,j);
    b(j) = b(j) - mult*b(j-1);
end
% to show system at this stage:  [A b]

% run back-substitution
x = zeros(n,1);
x(n) = b(n) / A(n,n);
for j = n-1:-1:1
    x(j) = (b(j) - A(j,j+1)*x(j+1)) / A(j,j);
end

