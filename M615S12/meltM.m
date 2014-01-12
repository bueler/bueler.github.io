function meltM(Jx,Jy,tf)
% MELTM  Reproduce figures 3.2--3.5 in Morton & Mayers using explicit
% scheme for solving heat equation in x,y.
% Example:   >> meltM(100,100,0.01);

% generate same grid as in formM
x = linspace(0,1,Jx+1);   dx = 1.0 / Jx;
y = linspace(0,1,Jy+1);   dy = 1.0 / Jy;
[xx,yy] = ndgrid(x,y);

% get initial state
u = formM(Jx,Jy);  close all
dt = 0.45 / (1/dx^2 + 1/dy^2);  % condition (3.10):  dt/dx^2 + dt/dy^2 <= 1/2
N = ceil(tf / dt)
dt = tf / N                     % guarantees N*dt = tf and N an integer
mux = dt / dx^2;  muy = dt / dy^2;

t = 0.0;
for n = 1:N
  if t == 0.0
    figure(1), subplot(2,2,1),  mesh(x,y,u),  axis off,  view(30,70)
  elseif ((t<=0.001) & (t+dt>0.001))
    subplot(2,2,3),  mesh(x,y,u),  axis off,  view(30,70)
  elseif ((t<=0.004) & (t+dt>0.004))
    subplot(2,2,2),  mesh(x,y,u),  axis off,  view(30,70)
  end
  unew = zeros(size(xx));  % allocates space and sets boundary condition
  unew(2:Jx,2:Jy) = u(2:Jx,2:Jy) + ...
                    mux * (u(3:Jx+1,2:Jy) - 2 * u(2:Jx,2:Jy) + u(1:Jx-1,2:Jy)) + ...
                    muy * (u(2:Jx,3:Jy+1) - 2 * u(2:Jx,2:Jy) + u(2:Jx,1:Jy-1));
  u = unew;  t = t + dt;
end
subplot(2,2,4),  mesh(x,y,u),  axis off,  view(30,70)
