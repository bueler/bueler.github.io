function [U,P] = polar(A)
% POLAR  For a square matrix A, compute the polar decomposition  A = U P  where
% U is unitary and P is hermitian and nonnegative-definite.  Note P is the
% unique nonnegative square root of A'*A.  For example:
%   >> A = randn(4,4);
%   >> [U,P] = polar(A);
%   >> norm(U*P-A), norm(P*P-A'*A), norm(U'*U-eye(4))
% Computation is by SVD, thus stable but not necessarily efficient.
% See https://en.wikipedia.org/wiki/Polar_decomposition

[m n] = size(A);
if m ~= n, error('A must be square'), end
[W,S,V] = svd(A);
P = V*S*V';
U = W*V';

