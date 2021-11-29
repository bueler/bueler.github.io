% HEATROD  In-class demo of solving heat flow in a rod problem

% rod of length 4 with a certain conductivity
L = 4;
K = 0.2;

% boundary temperatures
A = 0;
B = 3;

% cut up rod
n = 20;
dx = L / n;
x = (dx/2:dx:L-dx/2)';   % segment (cell) centers

% initial (random) temperature
g = 2 * (randn(size(x)) + 1);

% right-hand side of system
f = @(t,u) (K/dx^2) * [A - 2*u(1) + u(2);
                       u(1:n-2) - 2*u(2:n-1) + u(3:n);
                       u(n-1) - 2*u(n) + B];

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
