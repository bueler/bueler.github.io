% POWERTRIES  Some one-liners illustrating the "power method" for eigenvalues.

A = [3 -1 1; -1 -2 1; 1 1 2]       % has decent gap  lambda_1 > lambda_2

max(eig(A))

v = randn(3,1);  for k=1:60,  v = A*v;  v = v/norm(v);  end

lam = (A*v) ./ v                   % not great way of estimating lambda

r = (v'*(A*v)) / (v'*v)            % better: Rayleigh quotient


B = [3 -1 1; -1 pi 1; 1 1 3]       % has smaller gap  lambda_1 > lambda_2

max(eig(B))

v = randn(3,1);  for k=1:60,  v = B*v;  v = v/norm(v);  end

r = (v'*(B*v)) / (v'*v)

