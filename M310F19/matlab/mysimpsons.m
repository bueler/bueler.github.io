function z = mysimpsons(f,a,b,n);
% MYSIMPSONS  Basic implementation of Simpson's rule.  Compare MYTRAP.

if mod(n,2) ~= 0,  error('n must be even'),  end
h = (b-a)/n;  x = a:h:b;
c = [1 repmat([4 2],1,(n/2)-1) 4 1];
z = (h/3) * sum(c .* f(x));
