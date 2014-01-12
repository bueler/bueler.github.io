function [x,U,uexact] = porous(tf,J)
% POROUS  Numerically solves problem
%    u_t = ( 3 u^2 u_x )_x
% by finite differences on the interval -10 <= x <= 10, with comparison
% to an exact similarity solution.  Example:
%   >> [x,U,uinit] = porous(0.0,100);
%   >> [x,U,uexact] = porous(20.0,100);
%   >> err = max(abs(U-uexact))
%   >> figure(1), plot(x,uinit,'g',x,uexact,'r',x,U,'o','markersize',12)
%   >> legend('initial','exact','approx'), xlabel x, ylabel u

uex = @(x,t) (t+1).^(-0.25) * ( 1 - (1/12) * (t+1).^(-1/2) .* x.^2 ).^(1/2);
dx = 20/J;    x = -10:dx:10;

U = zeros(size(x));
U(abs(x) < sqrt(12)) = uex(x(abs(x) < sqrt(12)),0.0); % t=0 value of exact soln
t = 0.0;
while t < tf
  maxP = 3 * max(U)^2;
  dt = 0.4 * dx^2 / maxP; % dt by stability criterion (2.155)
  if t+dt>tf, dt = tf-t; end  % don't go past end
  Us = (U(1:J)+U(2:J+1)) / 2;  ps = 3 * Us.^2;  % staggered grid
  U(2:J) = U(2:J) + (dt/dx^2) * ( ps(2:J)   .* (U(3:J+1) - U(2:J)) - ...
                                  ps(1:J-1) .* (U(2:J) - U(1:J-1)) );
  t = t + dt;
end

uexact = zeros(size(x));
ind = (abs(x) < sqrt(12) * (tf+1)^(1/4));
uexact(ind) = uex(x(ind),tf);
