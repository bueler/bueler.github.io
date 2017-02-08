% FDRATES  Reproduce Figure 1.2 in LeVeque showing errors from several FD formulas.

h = [0.1 0.05 0.01 0.005 0.001];
u = @sin;                         % u is a function handle:  u = @(x) sin(x)
x = 1.0;   duexact = cos(x);
Dplus    = (u(x+h) - u(x)) ./ h;
D0       = (u(x+h) - u(x-h)) ./ (2.0 * h);
D3       = (2.0 * u(x+h) + 3.0 * u(x) - 6.0 * u(x-h) + u(x-2.0*h)) ./ (6.0 * h);
loglog(h,abs(Dplus - duexact),'k.-','markersize',18,
       h,abs(D0 - duexact),'k.-','markersize',18,
       h,abs(D3 - duexact),'k.-','markersize',18)
text(0.0015,2.0e-3,'D_+','fontsize',20)
text(0.0015,1.0e-6,'D_0','fontsize',20)
text(0.0015,1.0e-9,'D_3','fontsize',20)
axis([5.0e-4 0.2 1.0e-11 0.1])
