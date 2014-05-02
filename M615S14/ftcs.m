function ftcs(JJ,tf,dt)
% FTCS Attempt to apply forward-time, centered-space ("FTCS")
% finite difference scheme
%   U_j^{n+1} - U_j^n      U_{j+1}^n - U_{j-1}^n
%   ----------------- + a0 --------------------- = 0
%           dt                      2 dx
% to solve advection equation initial/boundary value problem
%   u_t - 2 u_x = 0,
%   u(x,0) = sin(5 x) + 1,
% on -1 < x < 1, with boundary condition u(1,t) = 0.
% DO NOT USE FTCS: the method is known to be unstable.
% Shows two figures, the surface of the exact solution (figure(1))
% and the surface of the approximate solution (figure(2)).
% Usage:
%   ftcs(J,tf,dt)
% Examples:
%   >> ftcs(50,2,0.1)     % clear instability
%   >> ftcs(50,2,0.01)    % better
%   >> ftcs(50,2,0.001)   % not apparent instability
%   >> ftcs(50,10,0.001)  % ... but it was lurking
%   >> ftcs(200,2,0.001)  % higher res

a0 = -2;
g = @(x) sin(5*x) + 1;

dx = 2 / JJ;
x = -1:dx:1;                           % JJ+1 points
NN = ceil(tf/dt);  dt = tf / NN;       % tf = NN * dt  exactly

nu = a0 * dt / dx
U = g(x);
Unew = zeros(size(U));
Uplot = zeros(NN,JJ+1);  Uplot(1,:) = U;
Uexact = Uplot;
for n = 1:NN
  Unew(2:JJ) = U(2:JJ) - (nu/2) * (U(3:JJ+1) - U(1:JJ-1));  % FTCS
  Unew(1) = U(1) - nu * (U(2) - U(1)); % obligatory upwind at downstream bdry
  Unew(JJ+1) = 0;                      % upstream boundary condition
  U = Unew;
  Uplot(n+1,:) = U;
  tnew = n*dt;
  inside = (x < 1 + a0 * tnew);
  Uexact(n+1,inside) = g(x(inside) - a0 * tnew);
end

figure(1),  surf(x,0:dt:tf,Uexact)
shading flat,  view(2)
xlabel x,  ylabel t,  title('exact  u(x,t)')

figure(2),  surf(x,0:dt:tf,max(0,min(2,Uplot)))
shading flat,  view(2)
xlabel x,  ylabel t,  title('approximation  U')

