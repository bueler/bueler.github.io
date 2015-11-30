% TESTCIRCUEIG   Examine eigenvalues of a random circulant matrix.
% Depends on:  CIRCU  at  bueler.github.io/M614F15/matlab/circu.m

v = randn(20,1);
C = circu(v);
lameig = eig(C);

F = zeros(20,20);  lam = zeros(20,1);
for k=1:20
  for j=1:20
    F(j,k) = exp(-i*(j-1)*(k-1)*2*pi/20);
  end
  lam(k) = F(:,k)' * v;
end

% check that our eigenvalues match the eig() result
norm(sort(abs(lameig)) - sort(abs(lam)))  /  norm(abs(lam))
norm(sort(real(lameig)) - sort(real(lam)))  /  norm(abs(lam))
norm(sort(imag(lameig)) - sort(imag(lam)))  /  norm(abs(lam))

% check that our 5th eigenvector matches our 5th eigenvalue
norm(C * F(:,5) - lam(5) * F(:,5)) / norm(F(:,5))
