function [W,R] = housestages(A);
% HOUSESTAGES computes R in A = QR by Householder triangularization,
% Trefethen & Bau Algorithm 10.1, but displaying the triangular stages
% along the way.  (Compare HOUSE.)  Also returns vectors "v" in matrix
% W which can be used to recover Q; see also FORMQ.
% Usage:  >> [W,R] = housestages(A)

[m n] = size(A);

B = A;   % this copy will have forced zeros
W = zeros(m,n);
for k = 1:n
    v = A(k:m,k);               % v is (m-k+1) x 1 column vector
    v(1,1) = sign(v(1,1)) * norm(v,2) + v(1,1);
    v = v / norm(v,2);
    A(k:m,k:n) = A(k:m,k:n) - 2 * v * (v' * A(k:m,k:n));
    W(k:m,k) = v;
    B(k:m,k:n) = A(k:m,k:n);    % copy updated entries
    B(k+1:m,k) = 0.0;           % force exact zeros
    disp(B)
    fprintf('\n')               % put in blank lines
end
R = triu(A(1:n,1:n));           % force exact zeros below diag
