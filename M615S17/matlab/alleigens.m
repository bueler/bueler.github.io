% ALLEIGENS Compute eigenvalues of the three problems S1,S2,S3

A = [2  2  2;
     2  1  1;
     2  1 -5];
fprintf('S1:\n'),  disp(eig(A)')

A = [ 0  2;
     -2  0];
fprintf('S2:\n'),  disp(eig(A)')

m = 25;  h = 1.0 / (m+1);
A = (1/h^2) * spdiags([ones(m,1), -2*ones(m,1), ones(m,1)], [-1, 0, 1],m,m);
lam = eig(A);
fprintf('S3:\n  ')
for j = 1:25,  fprintf('%.5f  ',lam(j)),  end
fprintf('\n')

