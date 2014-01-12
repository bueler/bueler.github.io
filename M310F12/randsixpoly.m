% RANDSIXPOLY  Generate 6 random points in the plane and put a polynomial
%    through them.  Plot the polynomial and print it as a string.

% generate points and plot them
x = randn(1,6);
y = randn(1,6);
plot(x,y,'bo','markersize',12)

% use built-in "vander" to generate polynomial
A = fliplr(vander(x));
b = y';
v = A \ b;      % v holds coefficients
xx = -3:.001:3;
P = v(1) + v(2)*xx + v(3)*xx.^2 + v(4)*xx.^3 + v(5)*xx.^4 + v(6)*xx.^5;

% plot curve
hold on, plot(xx,P,'r'), hold off
axis([-3 3 -12 12])  % big vertical range is controlled, even though
                     %   we may lose parts of the polynomial graph
grid on

% print the polynomial as a string
fprintf('result:\n')
fprintf('  P(x) = %f + %f x + %f x^2 + %f x^3 +\n',v(1),v(2),v(3),v(4))
fprintf('         + %f x^4 + %f x^5\n',v(5),v(6))
