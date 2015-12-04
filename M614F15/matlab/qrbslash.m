function x = qrbslash(A,b);
% QRBSLASH  Solve linear system Ax=b by in-place Householder QR
% factorization by calling IPHOUSE.

Z = iphouse(A);  m = size(A,1);
if length(b) ~= m,  error('size mismatch'),  end
x = zeros(m,1);
% algorithm 10.2 to solve  Q y = b  (i.e. get y = Q'*b)
y = b;
for k = 1:m
    y(k:m) = y(k:m) - 2 * Z(k:m,k) * (Z(k:m,k)' * y(k:m));
end
% back substitution to solve  R x = y
x(m) = y(m) / Z(m+1,m);    % diagonal of R is stored in last row of Z
for k = m-1:-1:1
    x(k) = (y(k) - Z(k,k+1:m) * x(k+1:m)) / Z(m+1,k);
end
