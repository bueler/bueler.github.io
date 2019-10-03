function z = absdet(A)
% ABSDET This is a reasonable way to compute the magnitude of the determinant
% by using Matlab's built-in LU decomposition to do all the work.
% Example:  >> A = randn(50,50);
%           >> absdet(A),  abs(det(A))  % these will be IDENTICAL
% WARNING:  To determine if a matrix is invertible use cond() or condest().

n = size(A,1);
if size(A,2) ~= n,  error('only works on square matrices'),  end

if n == 1
    z = abs(A(1,1));
elseif n == 2
    z = abs(A(1,1)*A(2,2) - A(1,2)*A(2,1));
else
    [L, U, P] = lu(A);
    % we lose the sign of the determinant, which is
    %   in the permutation matrix P
    z = abs(prod(diag(U)));
end
