function z = muller(f,xkm2,xkm1,xk,N)
% MULLER Apply N steps of Muller's method.  Muller's method
% is like secant method but instead of a line through the
% two most recent values we compute a quadratic q(x) through
% the three most recent values.  Then we find the root of q(x)
% that is closest to the most recent iterate.
% Example for Exer 2 in Chapter 8 of Greenbaum & Chartier
%   >> muller(@(x) x.^3-2,0,1,2,1)

xx = [xkm2    xkm1    xk   ];
ff = [f(xkm2) f(xkm1) f(xk)];

for k = 2:N+1
  %xx(3)   % <-- uncomment this to watch iterations
  alpha = ff(1) / ((xx(1) - xx(2))*(xx(1) - xx(3)));
  beta  = ff(2) / ((xx(2) - xx(1))*(xx(2) - xx(3)));
  gamma = ff(3) / ((xx(3) - xx(1))*(xx(3) - xx(2)));
  A = alpha + beta + gamma;
  B = - alpha * (xx(2)+xx(3)) - beta * (xx(1)+xx(3)) - gamma * (xx(1)+xx(2));
  C = alpha * xx(2) * xx(3) + beta * xx(1) * xx(3) + gamma * xx(1) * xx(2);
  disc = B^2 - 4*A*C;
  if disc < 0
    msg = sprintf('would generate complex numbers at step %d ... stopping',k)
    error(msg)
  elseif A == 0
    msg = sprintf('would divide by zero at step %d ... stopping',k)
    error(msg)
  end
  if B < 0   % choose stable ways to solve quadratic; avoid cancellation
    y  = - B + sqrt(disc);
    xp = y / (2 * A);
    xm = (2 * C) / y;
  else
    y  = - B - sqrt(disc);
    xp = (2 * C) / y;
    xm = y / (2 * A);
  end
  if abs(xx(2) - xm) < abs(xx(2) - xp)
    xx = [xx(2) xx(3) xm];
  else
    xx = [xx(2) xx(3) xp];
  end
  ff = [ff(2) ff(3) f(xx(3))];
end
z = xx(3);

