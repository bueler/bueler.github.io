function A = gennormal(n);
% GENNORMAL  Generate a random n x n complex matrix which *is* normal but is
% not hermitian.  The matrix will have eigenvalues which roughly cover the unit
% disc (when n is large).  Example:
%   >> A = gennormal(100);
%   >> [X,D] = eig(A);  lam = diag(D);
%   >> plot(real(lam),imag(lam),'o'),  grid on
% See also PROJMEASURE.

B = randn(n,n) / sqrt(n); % "circular law" (https://en.wikipedia.org/wiki/Circular_law)
                          %     says eigenvalues of B are (asymptotically)
                          %     uniformly distributed on unit disc
[X,D] = eig(B);           % D is diagonal and holds eigenvalues and
                          %     X holds (nonorthogonal) eigenvectors
[Q,R] = qr(X);            % Q now holds ON basis for C^n, build from applying
                          %     orthogonalization (think: Gram-Schmidt) to
                          %     columns of X
A = Q * D * Q';           % construct A to be normal but to have same
                          %     eigenvalues as B

