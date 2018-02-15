% COSTRAP  Shows n=4, n=8, and n=1000 results from applying the trapezoid
% rule to the integral
%    /2
%    |  cos(x^2) dx  ~~  0.46146
%    /1
% The result from QUAD is also shown, which is an even more accurate numerical
% approximation.  Note that lines which have a semicolon at the end will not
% produce output.

f = @(x) cos(x.^2)

% n = 4
dx = 2 / 4
x = 0:dx:2
y = f(x)
T4 = (dx/2) * (y(1) + 2 * sum(y(2:4)) + y(5))

% n = 8
dx = 2 / 8;
x = 0:dx:2;
y = f(x);
T8 = (dx/2) * (y(1) + 2 * sum(y(2:end-1)) + y(end))

% n = 1000
dx = 2 / 1000;
x = 0:dx:2;
y = f(x);
T1000 = (dx/2) * (y(1) + 2 * sum(y(2:end-1)) + y(end))

% from QUAD
quad(f,0,2)

