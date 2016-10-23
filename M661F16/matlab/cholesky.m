function [L, ifail] = cholesky(A)
% CHOLESKY  Implements Cholesky factorization.  Assumes input A is symmetric.
% If A is positive definite then result is L such that L L' = A and ifail = -1.
% If A is not positive definite then the algorithm will fail with ifail > 0
% giving the index of the diagonal entry A_ii which is negative (as the
% algorithm proceeds).

n = size(A,1);
if size(A,2) ~= n,  error('A must be square'),  end

ifail = -1;
L = zeros(n,n);
for i = 1:n            % i = column in which to put zeros
   if A(i,i) <= 0
       ifail = i;
       return;
   end
   L(i,i) = sqrt(A(i,i));
   for j = i+1:n       % will put zeros below the diagonal
       L(j,i) = A(j,i) / L(i,i);
       for k = i+1:j   % from our column to the diagonal position
           A(j,k) = A(j,k) - L(j,i) * L(k,i);
       end
   end
end
