function [W,R] = house(A);
% HOUSE computes R in A = QR by Householder triangularization.  Also
% returns vectors "v" in W which can be used to recover Q.  This is
% Trefethen & Bau Algorithm 10.1.  See CLGS, MGS for Gram-Schmidt
% versions and QR for Matlab's built-in version.
% Usage:
%   >> [W,R] = house(A)
% produces W and R upper triangular.  Do
%   >> Q = formQ(W)
% to get unitary Q factor if desired.

myeps = 2*eps; % use machine eps times 2
[m n] = size(A);
scal = max(max(abs(A)));

W = zeros(m,n);
for k = 1:n
    v = A(k:m,k); % size(v) = [m-k+1 1]
    if v(1,1) < 0,  v(1,1) = -norm(v,2) + v(1,1);
    else,           v(1,1) =  norm(v,2) + v(1,1);  end
    r = norm(v,2);
    if abs(r) / scal < myeps
        A(k:m,k) = 0.0;
        W(:,k) = zeros(m,1);
    else
        v = v / r;
        W(:,k) = [zeros(k-1,1); v]; 
        A(k:m,k:n) = A(k:m,k:n) - 2 * v * (v' * A(k:m,k:n));
    end
end
R = A(1:n,1:n);
