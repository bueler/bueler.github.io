% CHECKEIGS  Check the formula for eigenvalues in P17 (e) in case m = 5
v = [2 7 -4 6 -1]';  C = circu(v);
j = (1:5)';  lam = zeros(size(v));
for k=1:5
  fk = exp(- i * 2*pi * (k-1) * (j-1) / 5);
  lam(k) = fk' * v;
end
norm(sort(abs(lam)) - sort(abs(eig(C))))
norm(sort(real(lam)) - sort(real(eig(C))))
