function x = linearsolve0(A, b)
% LINEARSOLVE0  Solve a linear system  A x = b  using Gaussian
% elimination (LU factorization) followed by forward and backward
% substitution.  Calls LUFACT, FORWARDSUB, and BACKSUB.  Because
% LUFACT does not do pivoting, this code is *for demonstration
% only*; it is not stable for generic problems.
% Example with a random matrix, checking against backslash:
%   >> A = randn(5,5);  b = randn(5,1);
%   >> norm(linearsolve0(A,b) - A\b)

[L, U] = lufact(A);
z = forwardsub(L, b);
x = backsub(U, z);
