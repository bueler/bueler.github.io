function z = clencurt(f,N)
% CLENCURT Use polynomial interpolation at N+1 Chebyshev points
% x_j = cos(pi j/N) to do the integral  -->       /1
% That is, do Clenshaw-Curtis integration.        |  f(x) dx
% For example:                                    /-1
%   >> clencurt(@(x) cos(x),6)
% for which the exact answer is
%   >> 2 * sin(1)

x = cos(pi * (0:N) / N);
p = polyfit(x,f(x),N);
p = fliplr(p);
c = (1 - (-1).^(1:N+1)) ./ (1:N+1);
z = c * p';
