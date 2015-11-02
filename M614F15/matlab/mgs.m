function [Q,R] = mgs(A);
% MGS computes reduced QR decomposition by MODIFIED Gram-Schmidt,
% Trefethen & Bau Algorithm 8.1.
% Usage:
%    [Q,R] = mgs(A)

[m n] = size(A);  R = zeros(n,n);
Q = A;
for i = 1:n
    r = norm(Q(:,i),2);
    R(i,i) = r;
    w = Q(:,i)/r;
    Q(:,i) = w;
    for j = i+1:n
        r = w'*Q(:,j);
        R(i,j) = r;
        Q(:,j) = Q(:,j)-r*w;
    end
end
