function [x, U] = expscheme(J,L,N,tf,A,B,K,G)
% EXPSCHEME Apply first-order explicit scheme to solve the heat equation
% problem
%   u_t = K u_xx      t > 0, 0 < x < L,
%   u(0,t) = A        t > 0
%   u(L,t) = B        t > 0
%   u(x,0) = G(x)     0 < x < L
% until final time t = tf.  Use N subintervals in time and J
% subintervals in x.
% Usage:
%   >> [x,U] = expscheme(J,L,N,tf,A,B,K,G)
% Example:
%   >> [x,U] = expscheme(20,3,100,2,1,-4,0.1,@(x) exp(-x));
%   >> plot(x,U,'o-')

dt = tf / N;
dx = L / J;
mu = K * dt / dx^2;

x = 0:dx:L;
U = G(x);
U(1) = A;
U(J+1) = B;
for n = 1:N
    % the next line does not alter the endpoint (boundary) values
    U(2:J) = U(2:J) + mu * (U(3:J+1) - 2 * U(2:J) + U(1:J-1));
end
