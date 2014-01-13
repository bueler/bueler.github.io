function Q = formQ(W);
% FORMQ computes Q in A = QR using result of HOUSE.
%    This is Trefethen & Bau Algorithm 10.3.
%    Returned Q is m by n if W is m by n.

[m n] = size(W);
Q = zeros(m,n);
for i=1:n
    e = zeros(m,1);
    e(i) = 1;
    for k = n:-1:1
        v = W(k:m,k);
        e(k:m) = e(k:m) - 2 * v * (v' * e(k:m));
    end
    Q(:,i) = e;
end
