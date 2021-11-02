% WIGGLEPOLY  Plot (x-3)^10  different ways.  Via coefficients is bad.

% exact coefficients of p(x) = (x-3)^10 when expanded in monomials:
c = [1 -30 405 -3240 17010 -61236 153090 -262440 295245 -196830 59049];
x = 2.85:0.01:3.15;
ya = polyval(c,x);   % part (a)
yb = (x-3).^10;      % part (b)
plot(x,yb, x,ya)
legend('p(x)=(x-3)^{10}', 'same poly (by coefficients)')
axis tight,  grid on,  xlabel x
