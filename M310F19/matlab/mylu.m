function [p,Z] = mylu(A);
% MYLU  In-place Gauss elimination with partial pivoting to compute
% PA = LU, but with L and U in Z and with permutation represented
% by an integer vector.  Compare to [L,U,P] = lu(A).
% Example:
%    >> [p,Z] = mylu(A);
%    >> P = eye(m,m);  P = P(p,:)
%    >> U = triu(Z(p,:))
%    >> L = tril(Z(p,:),-1) + diag(ones(m,1))

if size(A,1) ~= size(A,2)
    error('only works on square matrices')
end

n = size(A,1);
p = 1:n;
Z = A;
for k=1:n-1
    [temp, ii] = max(abs(Z(p(k:n),k)));
    temp = p(k);
    p(k) = p(k+ii-1);
    p(k+ii-1) = temp;                      % p(k) now gives pivot row
    for j=k+1:n
        mult = Z(p(j),k) / Z(p(k),k);
        Z(p(j),k+1:n) = Z(p(j),k+1:n) - mult * Z(p(k),k+1:n);
        Z(p(j),k) = mult;                  % = L(j,k)
    end
end
