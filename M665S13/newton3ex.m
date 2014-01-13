% Newton's method to solve nonlinear system of 3 eqns in 3 unknowns

NN = 5;       % this many iterations gives residual norm of size eps
x = [1 1 1]'; % initial iterate

estimates(:,1) = x;
for n = 1:NN+1
  f = [x'*x - 4,    sin(2*pi*x(2)) - x(3),    x(1) - x(2)^2]';
  residual_norms(n) = norm(f);
  if n == NN+1,  break,  end;
  J = [  2*x(1),                2*x(2),         2*x(3); 
              0,   2*pi*cos(2*pi*x(2)),             -1;
              1,               -2*x(2),              0];
  s = J \ (-f);
  x = x + s;
  estimates(:,n+1) = x;
end

% show numbers
format short,    estimates
format short e,  residual_norms

% plot residual norms
semilogy(0:NN,residual_norms,'*','markersize',12)
axis([-0.5 NN+0.5 1.0e-16 5.0]),  grid on
xlabel('iteration  n')
