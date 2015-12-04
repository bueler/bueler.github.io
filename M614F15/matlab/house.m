function [W,R] = house(A);
% HOUSE computes R in A = QR by Householder triangularization,
% Trefethen & Bau Algorithm 10.1.  Also returns vectors "v" in matrix W
% which can be used to recover Q; see also FORMQ.
% Usage:
%   >> [W,R] = house(A)
% produces W and R upper triangular.  Do
%   >> Q = formQ(W)
% to get unitary Q factor if desired.

[m n] = size(A);

W = zeros(m,n);
for k = 1:n
    v = A(k:m,k); % size(v) = [m-k+1 1]
    v(1,1) = sign(v(1,1)) * norm(v,2) + v(1,1);
    v = v / norm(v,2);
    W(:,k) = [zeros(k-1,1); v]; 
    A(k:m,k:n) = A(k:m,k:n) - 2 * v * (v' * A(k:m,k:n));
end
R = triu(A(1:n,1:n));
