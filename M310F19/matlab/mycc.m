function z = mycc(f,n)
% MYCC A basic implementation of Clenshaw-Curtis quadrature
% on the fixed interval [-1,1] using Chebyshev-point polynomial
% interpolation of f via POLYFIT.  This code would be better if
% the barycentric formulas were used, but use CLENSHAWCURTIS
% for real work.  This implementation should not be trusted for
% large n (e.g. n>100); it will generate singular matrix warnings.
% Example:
%   >> I = mycc(@cos,11)
%   >> abs(I - 2*sin(1))

x = cos(pi * (0:n)/n);
p = polyfit(x,f(x),n);
c = 1./(n+1:-1:1);
z = polyval([c.*p 0],1) - polyval([c.*p 0],-1);

