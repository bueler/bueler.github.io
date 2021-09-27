function [Q,R] = clgs(A);
% CLGS Compute reduced QR factorization by CLASSICAL Gram-Schmidt,
% Trefethen & Bau Algorithm 7.1.  UNSTABLE!  Do not use for serious
% computation.  Try MGS or built-in QR (= Householder).
% Usage:
%    [Q,R] = clgs(A)

[m n] = size(A);
Q = zeros(m,n);
R = zeros(n,n);
for j = 1:n
    v = A(:,j);
    for i = 1:(j-1)
        R(i,j) = Q(:,i)' * A(:,j);
        v = v - R(i,j) * Q(:,i);
    end
    R(j,j) = norm(v,2);
    Q(:,j) = v / R(j,j);
end
