% EXER3ANALYSIS  Use manufactured problem with known exact
% solution to make sure EXER3SAFE is really right, by
% following refinement path and measuring the error.  Do
%   >> format long g
%   >> exer3analysis
% The left column shows J and the right shows the error.

g = @(x) sin(pi*x) .* (sin(5*x) - pi*pi);
levels = 4;
J = 10.^(1:levels);
err = ones(size(J));  % allocate space for err; clears err
for n = 1:levels;
  [x,v] = exer3safe(J(n),g);
  vexact = sin(pi * x);
  err(n) = max(abs(v-vexact));
end

[J' err']
