function weierstrauss(m)
% WEIERSTRAUSS  Plot m-th sums of the two nowhere-differentiable functions
% discussed in class,
%   phi(x) = sum_n=0^m  a^n cos(pi b^n x)    [a = 0.8, b = 9]
%   f(x)   = sum_n=0^m  2^(-n) g(2^n x)
% where g(x)=|x-round(x)| is the distance from x to the nearest integer.
% Example:  >> weierstrauss
%           >> weierstrauss(2)

if nargin < 1
    m = 10;
end

figure(1), clf
subplot(2,1,1)
x = 0:.0002:0.5;
a = 0.8;  b = 9.0;
phi = 0;
for n = 0:m
    phi = phi + a^n * cos(pi * b^n * x);
end
plot(x,phi),  grid on,  xlabel x
axis tight
title('\phi(x) = original Weierstrauss')

subplot(2,1,2)
x = -2:.001:2;
g = @(x) abs(x-round(x));
f = 0;
for n = 0:m
    f = f + g(2^n * x) / 2^n;
end
plot(x,f),  grid on,  xlabel x
axis tight
title('f(x) = Carothers version')



