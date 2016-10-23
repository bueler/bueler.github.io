function [L, ifail] = cholesky(A)
% CHOLESKY  Cholesky factorization  A = L L'.  Requires input A to be
% symmetric and have positive diagonal entries.  Succeeds if A is
% positive definite; then ifail = -1.  If A is not positive definite
% then the algorithm will fail with ifail >= 0.  If ifail > 0 then
% this gives the index of the (generated) diagonal entry which is negative.
%
% Usage:
%     [L, ifail] = cholesky(A)
%
% Example of success:
%   >> A = randn(4,4);  A = A'*A + eye(4,4);
%   >> L = cholesky(A)
%   >> norm(L * L' - A)              % should be small
%   >> L2 = chol(A,'lower')          % compare built-in
%   >> norm(L - L2)                  % should be small
%   >> [L,ifail] = cholesky(A)       % ifail = -1; success
%
% Example of failure:
%   >> A = [2 1 1; 1 1 -1; 1 -1 2]   % symmetric and with positive diagonal
%   >> eig(A)                        % shows not positive definite
%   >> [L,ifail] = cholesky(A)       % ifail = 3 so fails

n = size(A,1);
if size(A,2) ~= n,  error('A must be square'),  end
if norm(A-A') > 0,  ifail = 0;  error('A must be exactly symmetric'),  end
if any(diag(A) <= 0),  ifail = 0;  error('A must have positive diagonal'),  end

ifail = -1;
L = zeros(n,n);
for i = 1:n                    % i = column in which to put zeros
   if A(i,i) <= 0
       ifail = i;
       return;
   end
   L(i,i) = sqrt(A(i,i));
   for j = i+1:n               % will put zeros below the diagonal
       L(j,i) = A(j,i) / L(i,i);
       for k = i+1:j           % from our column to the diagonal position
           A(j,k) = A(j,k) - L(j,i) * L(k,i);
       end
   end
end
