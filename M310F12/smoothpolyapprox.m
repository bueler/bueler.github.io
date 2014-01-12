% SMOOTHPOLYAPPROX  build two 4th degree polynomial interpolants
%    of the smooth function  f(x) = 2^x  and compare them

% build and then plot P(x)
xP = [1, 1.5, 2, 2.5, 3];   yP = 2.^xP;
AP = fliplr(vander(xP));   v = AP \ yP';
xx = 0.5:0.0001:3;   % fine points at which to plot
P = v(1) + v(2)*xx + v(3)*xx.^2 + v(4)*xx.^3 + v(5)*xx.^4;
plot(xx,2.^xx,xx,P,'g',xP,yP,'gs','markersize',12), xlabel x

% build and then plot Q(x)
xQ = [1.0, 1.2, 1.5, 2.8, 3];   yQ = 2.^xQ;
AQ = fliplr(vander(xQ));   v = AQ \ yQ';  % new values for v
Q = v(1) + v(2)*xx + v(3)*xx.^2 + v(4)*xx.^3 + v(5)*xx.^4;
hold on, plot(xx,Q,'r',xQ,yQ,'ro','markersize',12), hold off
