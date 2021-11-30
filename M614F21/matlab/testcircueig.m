% TESTCIRCUEIG   Examine eigenvalues of a random circulant matrix.
% Depends on:  CIRCU

% set up a random C
m = 20;  v = randn(m,1);  C = circu(v);

% build the matrix F = [ f_1 | ... | f_m ]
F = zeros(m,m);
j = (1:m)';
for k=1:m
    F(:,k) = exp(-i*(j-1)*(k-1)*2*pi/m);
end

% compute eigenvalues according to part (e)
lam = F' * v;         % lam(k) = F(:,k)' * v = f_k^* v

% compute eigenvalues from built-in eig()
lameig = eig(C);

% check that our eigenvalues match the eig() result
norm(sort(abs(lameig)) - sort(abs(lam)))  /  norm(abs(lam))
norm(sort(real(lameig)) - sort(real(lam)))  /  norm(abs(lam))
norm(sort(imag(lameig)) - sort(imag(lam)))  /  norm(abs(lam))

% check   C f_5 = lambda_5 f_5
norm(C * F(:,5) - lam(5) * F(:,5)) / norm(F(:,5))
