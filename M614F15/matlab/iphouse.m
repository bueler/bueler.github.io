function Z = iphouse(A);
% IPHOUSE computes A = QR by in-place Householder triangularization.
% See also QRBSLASH.

m = size(A,1);  Z = [A; zeros(1,m)];
if size(A,2) ~= m, error('only works on square matrices'), end
for k = 1:m
    v = Z(k:m,k);
    Z(m+1,k) = - sign(v(1,1)) * norm(v,2);
    v(1,1) = sign(v(1,1)) * norm(v,2) + v(1,1);
    v = v / norm(v,2);
    Z(k:m,k+1:m) = Z(k:m,k+1:m) - 2 * v * (v' * Z(k:m,k+1:m));
    Z(k:m,k) = v; 
end
