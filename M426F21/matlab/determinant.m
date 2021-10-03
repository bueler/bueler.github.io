function z = determinant(A)
% DETERMINANT  Compute the determinant of a square matrix A
% via the LU factorization computed by LUFACT.  Compare the
% built-in Matlab command DET, which uses the same strategy.
% Example:
%   >> determinant([1 2 3; 4 5 6; 0 8 7])

[L, U] = lufact(A);
z = prod(diag(U));    % z = U_11 U_22 ... U_nn
