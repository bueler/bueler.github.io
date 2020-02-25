function A = genherm(n);
% GENHERM  Generate a random n x n real, symmetric (hermitian) matrix A.
% The entries have normal distributions.  The eigenvalues fill the
% interval [-2,2], distributed by the semicircle law, when n is large.
% Example:
%   >> A = genherm(100);  lam = eig(A);
%   >> plot(real(lam),zeros(1,100),'o'),  grid on,  axis([-2 2 -1 1])
%   >> figure(2),  hist(lam,20)
% See also GENNORMAL.

B = randn(n,n)/sqrt(n);
A = triu(B,1)' + triu(B);

