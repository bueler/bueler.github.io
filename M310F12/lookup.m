% LOOKUP  Build and test look-up table method using piecewise-linear
% approximation to f(x) = sin(x);

% build the table from N nodes
N = 1000;  x = linspace(0,pi,N);  dx = pi / (N-1);
y = sin(x);

% look-up in the table at M random points
M = 100;  r = pi * rand(M,1);

% do look-up operation and evaluate error
abserr = zeros(size(r));  relerr = abserr;     % allocate space
for j=1:M
  i = 1 + floor(r(j) / dx);                    % index into table
  l0 = - (r(j)-x(i+1)) / dx;   l1 = (r(j)-x(i)) / dx; % Lagrange
  pl = y(i) * l0  + y(i+1) * l1;               % interpolant
  exact = sin(r(j));
  abserr(j) = abs(pl - exact);
  relerr(j) = abserr(j) / abs(exact);
end
max(abserr),  max(relerr)
