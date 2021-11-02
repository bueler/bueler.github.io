function [f, J] = exellipsoid(u)
% EXELLIPSOID  Computes the residual function f(u) and the Jacobian
% J(u) for Exercise 4.5.5 in Driscoll & Braun. The nonlinear
% equations here are for the closest point on an ellipsoid
%   x^2/25 + y^2/16 + z^2/9 = 1
% to the point (5,4,3).  Note u = [x, y, z, lambda] where lambda
% is a Lagrange multiplier.

f = [u(1) - 5 - u(4) * u(1) / 25;
     u(2) - 4 - u(4) * u(2) / 16;
     u(3) - 3 - u(4) * u(3) / 9;
     1 - u(1)^2 / 25 - u(2)^2 / 16 - u(3)^2 / 9];

J = [1-u(4)/25,   0,           0,          -u(1)/25;
     0,           1-u(4)/16,   0,          -u(2)/16;
     0,           0,           1-u(4)/9,   -u(3)/9;
     -2*u(1)/25,  -2*u(2)/16,  -2*u(3)/9,  0];
