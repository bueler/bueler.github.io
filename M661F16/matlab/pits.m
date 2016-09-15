function [f, df, Hf] = pits(x)
% PITS Function with two local minima and one saddle.  Unique global minimum.

if length(x) ~= 2,  error('x must be length 2 vector'),  end
f = 2.0 * x(1)^4 - 4.0 * x(1)^2 + 10.0 * x(2)^2 + 0.5 * x(1) + x(1) * x(2);
df = [8.0 * x(1)^3 - 8.0 * x(1) + 0.5 + x(2);
      20.0 * x(2) + x(1)];
Hf = [24.0 * x(1)^2 - 8.0,  1.0;
      1.0,                 20.0];
end

