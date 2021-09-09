% ROOTTABLE Compute and print roots of x^2 - (2 + ep) x + 1.

for ep = 10.^(-4:-2:-12)
  b = 2 + ep;
  xm = (b - sqrt(b^2 - 4)) / 2;  % root of  x^2 - b x + 1
  xp = (b + sqrt(b^2 - 4)) / 2;  % other root
  fprintf('eps = %.1e:  x = %.6f, %.6f\n', ep, xm, xp)
end
