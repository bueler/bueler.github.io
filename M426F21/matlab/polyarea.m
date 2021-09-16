function A = polyarea(x,y)
% POLYAREA Compute the area of a polygon, based on Green's theorem.
% See https://en.wikipedia.org/wiki/Shoelace_formula and
% Exercise 1.3.3 in Driscoll & Braun.
% Example which finds the area of a unit square:
%   >> x = [0 1 1 0];  y = [0 0 1 1];
%   >> polyarea(x,y)

% check that the inputs make sense
n = length(x);
if length(y) ~= n
  error('inputs x and y must be arrays of the same length')
end

% accumulate the sum:   sum_{k=1}^n x_k y_{k+1} - x_{k+1} y_k
sum = 0.0;
for k = 1:n
  if k < n
    sum = sum + x(k) * y(k+1) - x(k+1) * y(k);
  else
    sum = sum + x(k) * y(1) - x(1) * y(k);
  end
end

% finalize the area
A = 0.5 * abs(sum);
