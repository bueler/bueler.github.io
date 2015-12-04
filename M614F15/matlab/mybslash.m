function x = mybslash(A,b)
% MYBSLASH  Solve linear system Ax=b by in-place LU factorization by
% calling MYLU.

Z = mylu(A);  m = size(Z,1);
if length(b) ~= m,  error('size mismatch'),  end
x = zeros(m,1);  y = x;
% forward substitution to solve  L y = b
y(1) = b(1);
for k = 2:m
    y(k) = b(k) - Z(k,1:k-1) * y(1:k-1);    %  note L(k,k) = 1
end
% back substitution to solve  U x = y
x(m) = y(m) / Z(m,m);
for k = m-1:-1:1
    x(k) = (y(k) - Z(k,k+1:m) * x(k+1:m)) / Z(k,k);
end
