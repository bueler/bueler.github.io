function [x, f, g, c, relerr] = fitxinv(m,a,b)
% FITXINV fits  f(x) = x^{-1}  by the least squares linear combination
%    g(x) = c_1 exp(x) + c_2 cos(x) + c_3 log(x)
% on the interval [a,b] using an equally-spaced grid of m points.
% It returns x and f(x) and g(x) for plotting.
% Example:
%   >> [x, f, g, c, relerr] = fitxinv(20,1,2);  c,  relerr
%   >> plot(x,f,'-o',x,g,'-*'),  xlabel x,  legend('1/x', 'fit')

% build discrete least-squares problem   A c = f
x = linspace(a,b,m)';
f = 1 ./ x;             % generates an error if x(j) = 0 for some j
A = [exp(x), cos(x), log(x)];

% solve least-squares problem
[Q, R] = qr(A,0);
c = R \ (Q' * f);
g = c(1) * exp(x) + c(2) * cos(x) + c(3) * log(x);
relerr = norm(g-f) / norm(f);
