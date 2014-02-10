function [x, U] = safeexpscheme(JJ,L,tf,A,B,K,G)
% SAFEEXPSCHEME Apply first-order explicit scheme to solve the
% heat equation problem
%   u_t = K u_xx      t > 0, 0 < x < L,
%   u(0,t) = A        t > 0
%   u(L,t) = B        t > 0
%   u(x,0) = G(x)     0 < x < L
% until final time t = tf.  Use J subintervals in x.
% Determines (and prints at the start), the number of subintervals
% in time according to the stability criterion
%    K dt / dx^2 <= 1 / 2
% Compare EXPSCHEME.
% Usage:
%   >> [x,U] = safeexpscheme(J,L,tf,A,B,K,G)
% Example:
%   >> [x,U] = safeexpscheme(20,3,2,1,-4,0.1,@(x) exp(-x));
%   >> plot(x,U,'o-')

if K <= 0, error('K must be positive'), end
if JJ <= 0, error('J must be positive and an integer'), end

dx = L / JJ;
maxdt = 0.5 * dx^2 / K;
N = ceil(tf / maxdt);
fprintf('  taking N = %d time-steps ...\n',N)
dt = tf / N;
mu = K * dt / dx^2;

x = 0:dx:L;
U = G(x);
U(1) = A;
U(JJ+1) = B;
for n = 1:N
    % the next line does not alter the endpoint (boundary) values
    U(2:JJ) = U(2:JJ) + mu * (U(3:JJ+1) - 2 * U(2:JJ) + U(1:JJ-1));
end
