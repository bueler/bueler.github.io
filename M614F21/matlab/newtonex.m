function newtonex(x, NN)
% NEWTONEX  Newton's method to solve a nonlinear system of 3 eqns in
% 3 unknowns.  Input initial iterate and number of steps:
%   >> newtonex([-1 1 1],6)
%   >> newtonex([-1 -1 1],6)

x = x(:);   % makes x a column vector
estimates(:,1) = x;
for n = 1:NN
  f = [x'*x - 4, x(1) - cos(pi*x(2)), x(3) - x(2)^2]';
  residual_norms(n) = norm(f);
  J = [  2*x(1),                2*x(2),         2*x(3); 
              1,       pi*sin(pi*x(2)),              0;
              0,               -2*x(2),              1];
  s = J \ (-f);
  x = x + s;
  estimates(:,n+1) = x;
end

% show numbers and plot residual norms
format long,  estimates
semilogy(0:NN-1, residual_norms, '*')
xlabel('iteration  n')
