% COMPAREBVP compare finite difference solutions to a b. v. p.

NN = [5 10 20 50 500];
style = 'brgmc';             % colors
for k = 1:length(NN)
  N = NN(k);
  x = linspace(0,3,N+1);
  [A,b] = assemble(N);
  U = A \ b;                 % solve system; tridiagonal means fast
  max(U)
  U = [0, U', 0];            % fix it up for plotting
  plot(x,U,style(k))
  hold on
end
hold off
xlabel('x'),  ylabel('U')
