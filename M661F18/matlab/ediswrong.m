function [f, df] = ediswrong(x)
% EDISWRONG  A quadratic function in 2D with a wrong gradient.

if length(x) ~= 2,  error('x must be length 2 vector'),  end
f = 5 * x(1)^2 + 0.5 * x(2)^2;
df = [5 * x(1);
      x(2)];

