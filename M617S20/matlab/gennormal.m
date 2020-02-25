function [A,B] = gennormal(n);
% GENNORMAL  Generate a random n x n complex matrix A which is normal
% (but not hermitian).  The entries have normal distributions.  The
% eigenvalues will roughly cover the unit disc when n is large.  Also
% returns B, a nonnormal matrix with the same eigenvalues as A.
% Example:
%   >> [A,B] = gennormal(100);
%   >> lam = eig(A);
%   >> plot(real(lam),imag(lam),'o'),  grid on    % same picture for B
%   >> norm(A'*A - A*A')     % very small
%   >> norm(B'*B - B*B')     % not small
% See also GENHERM, PROJMEASURE.

B = randn(n,n)/sqrt(n);  % https://en.wikipedia.org/wiki/Circular_law
                         %     says eigenvalues of B are asymptotically
                         %     uniformly distributed on unit disc
[X,D] = eig(B);          % D is diagonal and holds eigenvalues and
                         %     X holds (nonorthogonal) eigenvectors
[Q,R] = qr(X);           % Q holds ON basis for C^n, built from applying
                         %     orthogonalization to columns of X
A = Q*D*Q';              % construct A to be normal but to have same
                         %     eigenvalues as B

