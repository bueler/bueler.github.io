function U = runharder(J)
% RUNHARDER Run CNHARDER in case where exact solution is NOT known.

if nargin<1, J=20; end
f = @(x,t) exp(-t);
dx = 1.0 / J;  x = 0:dx:1;
tf = 1.0;  nu = 0.2;  dt = dx * nu;  N = ceil(tf/dt);
U0 = 1 - x;

U = cnharder(U0,N,tf,f);

plot(x,U0,x,U)
xlabel x, ylabel u
legend('U(x,0)','U(x,t_f)')
title(sprintf('result from J=%d, N=%d',J,N))
