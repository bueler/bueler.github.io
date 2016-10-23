function x = spdsolve(A,b)
% SPDSOLVE  Solves the linear system  A x = b  if A is symmetric positive
% definite (SPD).  Test for SPD-ness using CHOLESKY.  If A is SPD it gets
% L from CHOLESKY so that  L L' = A.  Then it solves two triangular systems
% using forward/back substitution by built-in means.  Reports an error
% if  A  is not SPD.
%
% Usage:
%     x = spdsolve(A,b)
%
% Example of success:
%   >> A = randn(4,4);  A = A'*A + eye(4,4);  b = randn(4,1);
%   >> x = spdsolve(A,b)
%   >> x2 = A \ b
%   >> norm(x - x2)
%
% Requires:  CHOLESKY

[L, ifail] = cholesky(A);
if ifail >= 0
    error(['cholesky factorization failed at index i = ' num2str(ifail)])
end
y = L \ b;
x = L' \ y;

