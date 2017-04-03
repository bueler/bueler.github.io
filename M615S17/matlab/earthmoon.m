function z = earthmoon(u,t)
% EARTHMOON Right-hand-side of ODE system   u' = f(u,t)   for Earth-Moon
% two-body gravity problem.  Components of u are in the following order:
%   u = [x1 y1 x2 y2 v1 w1 v2 w2]'

m1 = 5.972e24;                                   % mass of Earth in kg
m2 = 7.348e22;                                   % mass of Moon in kg
G = 6.674e-11;                                   % gravitational constant
d = ((u(1) - u(3))^2 + (u(2) - u(4))^2)^(3/2);
z = [u(5);  u(6);  u(7);  u(8);                  % first four entries
     - G * m2 * (u(1) - u(3)) / d;
     - G * m2 * (u(2) - u(4)) / d;
     - G * m1 * (u(3) - u(1)) / d;
     - G * m1 * (u(4) - u(2)) / d];
