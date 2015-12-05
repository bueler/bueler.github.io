% CLASS4DEC Show power iteration and naive QR on 3x3 matrices.

% A is non-hermitian
format short g
A = magic(3);
A(2,1) = 1    % breaks equal-magnitude pair of ew
eig(A)        % get eigenvalues for comparison

% power iteration = Tref&Bau Alg. 27.1   [almost]
v = randn(3,1);
for j=1:30
    v = A * v;
    v = v/norm(v);
end
A * v ./ v 

% naive QR = Tref & Bau Alg. 28.1
B = A;
for j=1:30
    [Q,R] = qr(B);
    B = R * Q;
end
B             % converging toward triangular (Schur thm)

% A is hermitian
A(3,1:2) = [6 7]
eig(A)
B = A;
for j=1:30
    [Q,R] = qr(B);
    B = R * Q;
end
B             % converging toward diagonal (spectral thm)

