% ADVECTEXACTSURF  Show surface for exact solution for Figure 4.8 in
% Morton & Mayers.

a = @(x,t) (1 + x.^2) ./ (1 + 2*x.*t + 2*x.^2 + x.^4);

% space-time grid
tf = 1.0;
N  = 100;
L  = 1.0;
J  = 100;
dx = L / J;
x  = 0:dx:L;
dt = tf / N;
t  = 0:dt:tf;

% functions
uinitial = @(x) exp(-10 * (4 * x - 1).^2);
xstar    = @(x,t) x - t ./ (1 + x.^2);

% plot exact solution as mesh
[xx,tt] = meshgrid(x,t);
uexact   = zeros(size(xx));            % already correct above t=x(1+x^2)
low      = (tt < xx .* (1 + xx.^2));   % boolean array for formulas
xs       = xstar(xx,tt);
uexact(low) = uinitial(xs(low));
figure(1),  mesh(x,t,uexact),   title('exact u(x,t)')
xlabel x,  ylabel t,  zlabel u
