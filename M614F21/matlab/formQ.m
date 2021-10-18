function Q = formQ(W);
% FORMQ computes Q in A = QR using result of HOUSE, using Alg. 10.3
% from Trefethen & Bau.  The returned Q is m x m if W is m x n.
% See HOUSE for usage.

[m n] = size(W);
if m < n,  error('the wide case (m<n) is not implemented'),  end
Q = zeros(m,m);
for i=1:m
    e = zeros(m,1);
    e(i) = 1;                % e = e_i
    for k = n:-1:1           % apply Alg. 10.3 to build Q e_i
        v = W(k:m,k);
        e(k:m) = e(k:m) - 2 * v * (v' * e(k:m));
    end
    Q(:,i) = e;              % put Q e_i into Q
end
