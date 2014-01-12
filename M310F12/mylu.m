function [p,Z] = mylu(A);
% MYLU    In-place Gauss elimination with partial pivoting to compute PA = LU.
% Compare to [L,U,P] = lu(A):
%    >> [p,Z] = mylu(A);
%    >> P = eye(m,m);  P = P(p,:)
%    >> U = triu(Z(p,:)),  L = tril(Z(p,:),-1) + diag(ones(m,1))

if size(A,1)~=size(A,2), error('only works on square matrices'), end
m = size(A,1);  p = 1:m;
Z = A;
for k=1:m-1
   [temp, ii] = max(abs(Z(p(k:m),k)));
   temp = p(k);
   p(k) = p(k+ii-1);
   p(k+ii-1) = temp; % p(k) now gives pivot row
   for j=k+1:m
      mult = Z(p(j),k) / Z(p(k),k);
      Z(p(j),k+1:m) = Z(p(j),k+1:m) - mult * Z(p(k),k+1:m);
      Z(p(j),k) = mult;  % = L(j,k)
   end
end
