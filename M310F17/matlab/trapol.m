function z = trapol(f,a,b,n)
% TRAPOL  Implement the composite trapezoid rule as a one-liner.  Compare TRAP.

h = (b - a) / n;
x = a:h:b;
c = [0.5, ones(1,n-1), 0.5];   % the coefficients
z = h * sum(c .* f(x));

