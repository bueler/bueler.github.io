% MONTE2D  Example of Monte Carlo integration in 2D
% Let R be the region in the first quadrant which is
% between  y = x^2 / 4  (i.e. above it) and  y = e^-x
% (below that).  Compute
%   /
%   |    cos(x^3 + y) dx dy
%   / R
% Note that we see that  R  is inside the rectangle
% [0,2] x [0,1] which has area  A = 2.

N = 1000000;
A = 2;
S = 0; % the sum
for j = 1:N
  x = 2 * rand;  y = rand;
  if (y > x^2/4) & (y < exp(-x))
    S = S + cos(x^3 + y);
  end
end
result = S * A / N
