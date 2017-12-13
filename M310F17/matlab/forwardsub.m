function x = forwardsub(A,b)
% FORWARDSUB  Forward-substitution for a lower triangular system.
n = size(A,1);
x = zeros(n,1);
x(1) = b(1) / A(1,1);                 % 1 op
for k = 2:n
    s = b(k);
    for j = 1:k-1
        s = s - A(k,j) * x(j);        % 2 ops
    end
    x(k) = s / A(k,k);                % 1 op
end
