function z = mytrap(f,a,b,n);
% MYTRAP  Basic implementation of trapezoid rule.  Called by MYROMBERG.

h = (b-a)/n;  x = a:h:b;
c = [1 2*ones(1,n-1) 1];
z = (h/2) * sum(c .* f(x));
