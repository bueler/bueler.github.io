function circling(k,NN)
% CIRCLING  Demonstrate forward Euler, Runge-Kutta 2, Runge-Kutta 4 on a problem
% where the exact solution is a circle:
%   x' = -y
%   y' = x
% with initial condition x(0)=1, y(0)=0.   Generates a plot.
% Example:
%   >> circling(0.7,10)       % long steps to t=7.0
%   >> circling(pi/50,100)    % short steps to t=2*pi
%   >> axis([0.999 1.001 -0.01 0.01])

u0 = [1, 0]';
A = [0, -1;      % ODE system is:  u' = A u
     1,  0];

figure(1)
plot(u0(1),u0(2),'k*','markersize',16)
hold on,  grid on

uFE = u0;
uRK2 = u0;
uRK4 = u0;
for n = 1:NN
    % forward Euler: page 120 of LeVeque
    nuFE = uFE + k * A * uFE;
    % Runge-Kutta order 2: page 124
    ustar = uRK2 + 0.5 * k * A * uRK2;
    nuRK2 = uRK2 + k * A * ustar;
    % Runge-Kutta order 4: page 126
    Y2 = uRK4 + 0.5 * k * A * uRK4;
    Y3 = uRK4 + 0.5 * k * A * Y2;
    Y4 = uRK4 + k * A * Y3;
    nuRK4 = uRK4 + (k / 6.0) * (A * uRK4 + 2.0 * A * Y2 + 2.0 * A * Y3 + A * Y4);

    % plot all these steps
    plot([uFE(1), nuFE(1)],[uFE(2), nuFE(2)],'b-o')
    plot([uRK2(1), nuRK2(1)],[uRK2(2), nuRK2(2)],'g-o')
    plot([uRK4(1), nuRK4(1)],[uRK4(2), nuRK4(2)],'r-o')

    % actually take step
    uFE = nuFE;
    uRK2 = nuRK2;
    uRK4 = nuRK4;
end
hold off,  xlabel x,  ylabel y
%axis tight, axis square
title('blue = FE, green = RK2, red = RK4')

