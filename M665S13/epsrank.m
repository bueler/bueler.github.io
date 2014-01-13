function z = epsrank(A,myeps)
% EPSRANK  Approximates rank(A) by the criterion that r = k is the
% largest index so that  sigma_j >= myeps * sigma_1.  Compare RANK.

if nargin < 2, myeps = 1.0e-6; end  % compare RANK, which is smarter

S = svd(A);                         % column vector of singular values

z = max(find( S >= myeps * S(1) ));
