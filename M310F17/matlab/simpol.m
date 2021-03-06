function z = simpol(f,a,b,n)
% SIMPOL  Implement the composite Simpson's rule as a one-liner.
% Requires the integrand f(x) to be vectorized.  Compare TRAPOL.
% Example:  >> simpol(@(x) x.^3,0,1,6)

if n <= 0, error('n must be positive'), end
if mod(n,2) ~= 0, error('n must be even'), end
h = (b - a) / n;
x = a:h:b;
c = [1, repmat([4 2],1,(n-2)/2), 4, 1];   % the coefficients
z = (h / 3) * sum(c .* f(x));

