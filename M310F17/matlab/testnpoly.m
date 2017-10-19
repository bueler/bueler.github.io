% TESTNPOLY  Test the Newton-form polynomial interpolation pair
% NPOLYFIT, NPOLYVAL.

f = @(x) sin(5 * x);
xi = [0 1 2 2.5 pi];
p = polyfit(xi,f(xi),4);         % coefficients in standard form
a = npolyfit(xi,f(xi),4);        % coefficients in Newton form
xx = -1:.01:4;
figure(1),  plot(xx,f(xx),xx,polyval(p,xx),xi,f(xi),'o')
figure(2),  plot(xx,f(xx),xx,npolyval(a,xi,xx),xi,f(xi),'o')

