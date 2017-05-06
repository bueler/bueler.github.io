function [x,U,N,utildeerr] = rk2ad(h,k,tf)
% RK2AD  Use RK2 method to solve centered-space approximation of advection-
% diffusion equation
%     u_t + b u_x = D u_xx + f(x),
% in the case where b = 10, D = 1, and f(x) = exp(-x), on 0 < x < 1 and
% 0 <= t <= tf.  Initial condition is u(x) = sin^10(pi x).  Plots both
% the solution U which approximates u(x,tf), and the by-hand-computed
% steady state solution utilde(x), and reports the difference.
% Usage:  [x,U,N,utildeerr] = rk2ad(h,k,tf)
% Example:
%   >> h = 0.05;  k = 0.001;  [x,U] = rk2ad(h,k,0.1);
% Requires:  MATAAD

b = 10.0;  D = 1.0;
A = matAad(b,D,h);
x = (h:h:1.0-h)';  F = exp(-x);  U = (sin(pi*x)).^(10);
N = ceil(tf / k);  k = tf / N;
for l = 1:N
    Ustar = U + (k/2) * (A * U + F);
    U = U + k * (A * Ustar + F);
end
c1 = (exp(10)-exp(-1)) / (11*(exp(10)-1));
c2 = - (1-exp(-1)) / (11*(exp(10)-1));
utilde = c1 + c2*exp(10*x) - (1/11)*exp(-x);
plot(x,U,'k',x,utilde,'k--'),  legend('U','utilde'),  xlabel x
utildeerr = norm(U-utilde,'inf');
