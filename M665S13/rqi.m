function lambda = rqi(A,show)
% RQI  Rayleigh quotient iteration, starting from random vector, to
% estimate an eigenvalue of A.  Does at most 7 iterations (and shows
% them if show=true).  See Algorithm 27.3 in Trefethen & Bau.
% Example on random hermitian:
%   >> A = randn(5);  A = A' * A;
%   >> eig(A)
%   >> rqi(A)
% To see iteration, which has *cubic* convergence, do:
%   >> rqi(A,true)

if nargin < 2, show = false; end
[m n] = size(A);
if m ~= n, error('A must be square to have eigenvalues'), end

v = randn(m,1);
v = v / norm(v);
lambda = v' * (A * v);             % = r(v), the Rayleigh quotient
for k = 1:6
  if show,  fprintf('  [estimated lambda = %.15g]\n',lambda), end
  M = A - lambda * eye(m,m);
  if rcond(M) < 5e-16, break, end  % this ought to catch all,
                                   %   but it doesn't, quite
  w = M \ v;
  v = w / norm(w);
  lambda = v' * (A * v);           % = r(v), the Rayleigh quotient
end
