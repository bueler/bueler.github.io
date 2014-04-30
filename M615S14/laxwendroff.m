function [maxerr, x, Ufinal, Uexactfinal] = laxwendroff(JJ,tf)
% LAXWENDROFF  Apply finite difference scheme
%   U_j^{n+1} = 0.5 nu (1+nu) U_{j-1}^n + (1 - nu^2) U_j^n
%                         - 0.5 nu (1-nu) U_{j+1}^n
% where nu = a_0 dt /dx, to solve advection equation
%   u_t + a_0 u_x = 0,
% where a_0 = -2, on -1 < x < 1, with u(x,0) = sin(5 x) + 1
% and boundary condition u(1,t) = 0.  Uses CFL condition to determine time
% step from "|nu|=1"; prints dx, dt, nu.  Shows two figures: figure(1)
% shows the exact and approximate solutions.  figure(2) shows the
% difference between them.  Reports the maximum error in [-1,1] x [0,tf].
%
% Usage:     [maxerr, x, Ufinal, Uexactfinal] = laxwendroff(J,tf)
% Example:   >> laxwendroff(50,2)

a0 = -2;
g = @(x) sin(5*x) + 1;

dx = 2 / JJ;  x = -1:dx:1;             % JJ+1 points
dt = min(dx / abs(a0), tf);            % |nu|=1  <==>  dt = dx/a0
NN = ceil(tf / dt);  dt = tf / NN;
nu = a0 * dt / dx;
fprintf('  laxwendroff:  for dx = %.5f, CFL gives dt = %.3f and nu = %.3f.\n',...
        dx,dt,nu)

U = g(x);
Unew = zeros(size(U));
Uplot = zeros(NN,JJ+1);  Uplot(1,:) = U;
Uexact = Uplot;
cm1 = 0.5 * nu * (1+nu);
c0  = 1 - nu^2;
cp1 = -0.5 * nu * (1-nu);
for n = 1:NN
  Unew(2:JJ) = cm1 * U(1:JJ-1) + c0 * U(2:JJ) + cp1 * U(3:JJ+1); % L.-W.
  Unew(1) = U(1) - nu * (U(2) - U(1)); % obligatory upwind at downstream bdry
  Unew(JJ+1) = 0;                      % upstream boundary condition
  U = Unew;
  Uplot(n+1,:) = U;
  tnew = (n+1)*dt;
  inside = (x < 1 + a0 * tnew);
  Uexact(n+1,inside) = g(x(inside) - a0 * tnew);
end

figure(1)
subplot(2,1,1),  surf(x,0:dt:tf,Uexact)
shading flat,  view(2),  ylabel t,  title('exact  u')
subplot(2,1,2),  surf(x,0:dt:tf,Uplot)
shading flat,  view(2),  xlabel x,  ylabel t,  title('approximation  U')

figure(2),  surf(x,0:dt:tf,Uplot-Uexact)
shading flat,  view(2),  colorbar
xlabel x,  ylabel t,  title('difference  U - u')
maxerr = max(max(abs(Uplot - Uexact)));
Ufinal = U;  Uexactfinal = Uexact(end,:);
