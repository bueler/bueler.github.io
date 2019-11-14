function I = mycc(f,n)
% MYCC A basic implementation of Clenshaw-Curtis quadrature on the fixed
% interval [-1,1] using Chebyshev-point polynomial interpolation of f
% via POLYFIT.  Use CLENSHAWCURTIS for real work.  This implementation
% should not be trusted for large n (e.g. n>30); it generates singular
% matrix warnings.  Example:
%   >> I = mycc(@cos,11)
%   >> abs(I - 2*sin(1))

x = cos(pi*(0:n)/n);
p = polyfit(x,f(x),n);
c = [p ./ (n+1:-1:1) 0];    % coefficients of antideriv. of p(x)
I = polyval(c,1) - polyval(c,-1);
