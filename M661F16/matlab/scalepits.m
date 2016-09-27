function [f, df, Hf] = scalepits(x)
scale = 4.0;
if length(x) ~= 2,  error('x must be length 2 vector'),  end
f = 2.0 * x(1)^4 - 4.0 * x(1)^2 + 10.0 * (scale*x(2))^2 + 0.5 * x(1) + x(1) * (scale*x(2));
df = [8.0 * x(1)^3 - 8.0 * x(1) + 0.5 + (scale*x(2));
      scale * (20.0 * (scale*x(2)) + x(1))];
Hf = [24.0 * x(1)^2 - 8.0,  scale;
      scale,                20.0 * scale^2];
end

