function [f, df, Hf] = easy2dquad(x)
% EASY2DQUAD  Easy to minimize quadratic function in 2D with unique minimum 0.

if length(x) ~= 2,  error('x must be length 2 vector'),  end
f = 5 * x(1)^2 + 0.5 * x(2)^2;
df = [10 * x(1);
      x(2)];
if nargout > 2
   Hf = [10, 0; 0, 1];
end

