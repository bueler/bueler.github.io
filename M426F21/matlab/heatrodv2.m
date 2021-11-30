% HEATRODV2  In-class demo of solving heat flow in a rod problem.
% This version 2 fixes a cell-centering problem.  Basically it
% shows a different approach to the boundary values, which is a
% bit more accurate.

% rod of length 4 with a certain conductivity
L = 4;
K = 0.2;

% boundary temperatures
A = 0;
B = 3;

% cut up rod
n = 20;
dx = L / n;
x = 0:dx:L;   % segment (cell) centers; n+1 points

% initial temperature; random at interior points
g = [A;
     2 * (randn(n-1,1) + 1);
     B];

% right-hand side of system
f = @(t,u) (K/dx^2) * [0;  % u_1'(t)=0 since boundary temp is constant
                       u(1:n-1) - 2*u(2:n) + u(3:n+1);
                       0]; % u_{n+1}'(t)=0 same reason

% solve
tf = 10.0;  % duration of simulation
[t,u] = ode45(f, [0,tf], g);

% make movie
for j = 1:length(t)
    plot(x,u(j,:),'ro:', [0 L],[A B],'bo')
    axis([0 L -2 5]),  xlabel x,  ylabel('temperature')
    title(sprintf('t = %.4f',t(j)))
    pause(0.1)
end
