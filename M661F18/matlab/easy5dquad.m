function [f, df] = easy5dquad(x)
% EASY5DQUAD  Easy to minimize quadratic function in 5D with unique minimum 0.

if length(x) ~= 5,  error('x must be length 5 vector'),  end
f = 10 * x(1)^2 + 5 * x(2)^2 + 1 * x(3)^2 + 0.5 * x(4)^2 + 0.1 * x(5)^2;
df = [20 * x(1);
      10 * x(2);
      2 * x(3);
      x(4);
      0.2 * x(5)];

