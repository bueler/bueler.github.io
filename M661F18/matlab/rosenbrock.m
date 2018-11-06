function [f, df] = rosenbrock(x)
% ROSENBROCK Famous banana-contoured quartic function with unique global minimum.

if length(x) ~= 2,  error('x must be length 2 vector'),  end
f = 100 * (x(2) - x(1)^2)^2 + (1 - x(1))^2;
df = [- 400 * x(1) * (x(2) - x(1)^2) - 2 * (1 - x(1));
      200 * (x(2) - x(1)^2)                           ];

