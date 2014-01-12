% TESTOPCOUNT  Runs GENOPIVOT and USOLVE on fairly large matrices
% to show operation counts and timing.

for n = [10 20 50 100 200 500 1000]
  fprintf('\nCASE n=%d:\n',n)
  A = randn(n,n);  x = randn(n,1);  b = A * x;  % system w known soln
  t = cputime();
  [A, b] = genopivot(A,b);                      % prints op count
  fprintf('  time for Gauss-elimination stage = %.3f s\n',cputime()-t)
  t = cputime();
  xx = usolve(A,b);
  fprintf('  time for back-substitution stage = %.3f s\n',cputime()-t)
end

