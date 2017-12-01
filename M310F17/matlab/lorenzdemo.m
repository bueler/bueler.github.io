% LORENZDEMO  Show solutions of the Lorenz equations, and the butterfly-
% shaped strange attractor.

% the equations
sigma = 10;
beta = 8/3;
rho = 28;
f = @(t,w) [sigma * (w(2)-w(1));
            w(1) * (rho-w(3)) - w(2);
            w(1) * w(2) - beta * w(3)];

% allow the ODE black box to choose the t-values
warning('off','all')  % suppress Octave warning if desired
[tt,WW] = ode45(f,[0,50],[1; 1; 1]);
size(tt)

% force the ODE black box to use 5001 equally-spaced t-values
[tt,WW] = ode45(f,0:.01:50,[1; 1; 1]);

% show a t-versus-solution plot
figure(1)
plot(tt,WW)
legend('x','y','z')
xlabel t

% show a "state-space" plot where we only see x,y,z and no t;
% this is the "strange attractor"; rotate this figure
figure(2)
x = WW(:,1);
y = WW(:,2);
z = WW(:,3);
plot3(x,y,z)
xlabel x, ylabel y, zlabel z

% show solutions from two slightly-different initial conditions
figure(3)
[tt,WW] = ode45(f,0:.01:5,[3; -20; 40]);
plot3(WW(:,1),WW(:,2),WW(:,3));
hold on
[tt,WW] = ode45(f,0:.01:5,[3.1; -20; 40]);
plot3(WW(:,1),WW(:,2),WW(:,3),'r');
xlabel x, ylabel y, zlabel z

