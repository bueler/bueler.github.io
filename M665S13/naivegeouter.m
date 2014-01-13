function [L, U] = naivegeouter(A)
% NAIVEGEOUTER  Gauss elimination without pivoting, but in "outer
% product form".  Compare NAIVEGE.  DO NOT USE FOR SERIOUS WORK.

[m n] = size(A);
if m ~= n, error('only works for square matrices'), end
U = A;  L = eye(m,m);
for k = 1:m-1                      % put zeros in these columns
  L(k+1:m,k) = U(k+1:m,k) / U(k,k);
  U(k+1:m,k:m) = U(k+1:m,k:m) - L(k+1:m,k) * U(k,k:m);
end
