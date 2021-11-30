function A = growth(N,perturb)
% GROWTH  Generate matrix (22.4) with a worst-case growth factor.

if nargin < 2,  perturb = 0.0;  end
below = -1 * ones(N,N) + perturb * rand(N,N);
A = tril(below,-1) + eye(N,N);
A(:,N) = 1;
