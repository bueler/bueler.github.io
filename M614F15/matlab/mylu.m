function Z = mylu(A)
% MYLU  In-place LU factorization.  See also MYBSLASH.

Z = A;  m = size(A,1);
if size(A,2) ~= m, error('only works on square matrices'), end
for k = 1:m-1
    for j = k+1:m
        Z(j,k) = Z(j,k) / Z(k,k);
        Z(j,k+1:m) = Z(j,k+1:m) - Z(j,k) * Z(k,k+1:m);
    end
end
