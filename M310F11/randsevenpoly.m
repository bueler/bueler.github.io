% RANDSEVENPOLY  Generate 7 random points in the plane and put a polynomial
%    through them.  Plot the polynomial and print it as a string.

% generate points and plot them
x = randn(1,7);
y = randn(1,7);
plot(x,y,'bo','markersize',12)

% use built-in "vander" to generate polynomial
A = fliplr(vander(x));
b = y';
v = A \ b;      % v holds coefficients
xx = -3:.001:3;
P = v(1) + v(2)*xx + v(3)*xx.^2 + v(4)*xx.^3 + v(5)*xx.^4 + v(6)*xx.^5 + v(7)*xx.^6;

% add polynomial to figure
hold on, plot(xx,P,'r'), hold off
axis([-3 3 -20 20])  % crazy vertical range is controlled, even though we lose
                     %   parts of the polynomial graph
%print -dpdf randsevenpoly.pdf  % uncomment this line to put it in PDF figure
                     
% print the polynomial as a string; this could be done by hand, too
fprintf('result:\n')
fprintf('  P(x) = %f + %f x + %f x^2 + %f x^3 + %f x^4 + %f x^5 + %f x^6\n',
        v(1),v(2),v(3),v(4),v(5),v(6),v(7))
