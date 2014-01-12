function err = runmanu(J)
% RUNMANU Run CNHARDER in case where exact solution IS known.

if nargin<1, J=20; end
f = @(x,t) sin(3*pi*x) .* (1 + t * (9*pi^2*(2-x.^2) - 1));
dx = 1.0 / J;  x = 0:dx:1;
tf = 1.0;  nu = 0.2;  dt = dx * nu;  N = ceil(tf/dt);
U0 = zeros(size(x));
Uexact = tf * sin(3*pi*x);

U = cnharder(U0,N,tf,f);
err = max(abs(U-Uexact));
fprintf('result from J=%3d, N=%4d:  err = %.3e\n',J,N,err)

% return   % uncomment to avoid plot

plot(x,U,x,Uexact)
xlabel x, ylabel u
legend('U(x,t_f)','Uexact(x,t_f)')
title(sprintf('result from J=%d, N=%d',J,N))
