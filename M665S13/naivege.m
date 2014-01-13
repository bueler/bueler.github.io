function [L, U] = naivege(A)
% NAIVEGE  Gauss elimination without pivoting.  Implements Alg 20.1
% in Trefethen and Bau.  DO NOT USE FOR SERIOUS WORK.

[m n] = size(A);
if m ~= n, error('only works for square matrices'), end
U = A;  L = eye(m,m);
for k = 1:m-1                      % put zeros in these columns
  for j = k+1:m                    % operate on these rows
    L(j,k) = U(j,k) / U(k,k);
    U(j,k:m) = U(j,k:m) - L(j,k) * U(k,k:m);
  end
end
