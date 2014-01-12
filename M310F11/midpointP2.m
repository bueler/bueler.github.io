% MIDPOINTP2  Generate six midpoint estimates of the integral
%    /-1       1
%    |    ----------- dx
%    / 1   2 + cos x

format long

for N = [20 40 80 160 320 640]
  h = 2/N;
  x = -1+(h/2):h:1-(h/2);
  f = 1./(2+cos(x));
  sum(f)*h
end
