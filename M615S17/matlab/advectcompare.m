function advectcompare(m,tf,ic)
% ADVECTCOMPARE On advection equation
%     u_t + a u_x = 0
% for u(x,t), with periodic boundary conditions on [0,1], a=1, and choice of
% two initial conditions u(x,0).  Uses m+1 grid points and a spatial
% grid with h = 1/(m+1).  If tf = 0 mod 1 then plots exact solution in red.
% Compares 3 space-time discretized methods
%     upwind
%     Lax-Friedrichs
%     Lax-Wendroff
% all subject to CFL.  Computes time-step k by version of CFL:
%     nu = a k / h = C    where C = .91111 < 1
% Usage:  >> advectcompare(m,tf,ic)

% generate space grid and time-step
a = 1.0;
h = 1.0 / (m+1);
x = 0:h:1.0-h;        % interpret as periodic grid
C = 0.91111;
k = C * h / a;        % CFL says:  a k <= h
NN = ceil(tf / k)     % fix k so integer number of steps

% initial condition
if ic == 0
    U = ones(size(x));  U(x < 0.4) = 0.0;  U(x > 0.6) = 0.0;
else
    U = sin(pi * x).^20;
end

% solve advection equation
Uup = U;  Ulf = U;  Ulw = U;
if NN > 0
    k = tf / NN;
    nu = a * k / h;
    for n = 1:NN
        Uup = (1.0 - nu) * Uup + nu * left(Uup);
        Ulf = 0.5 * (1.0 + nu) * left(Ulf) + 0.5 * (1.0 - nu) * right(Ulf);
        Ulw = 0.5 * nu * (nu + 1.0) * left(Ulw) + (1.0 - nu^2) * Ulw ...
              + 0.5 * nu * (nu - 1.0) * right(Ulw);
    end
end

axisbox = [0.0 1.0 -0.3 1.3];
figure(1),  clf
subplot(3,1,1),  plot(x,Uup,'k-o'),  axis(axisbox),  grid on,  title('upwind')
subplot(3,1,2),  plot(x,Ulf,'k-o'),  axis(axisbox),  grid on,  title('Lax-Friedrichs')
subplot(3,1,3),  plot(x,Ulw,'k-o'),  axis(axisbox),  grid on,  title('Lax-Wendroff')
if abs(mod(tf + 1.0e-10,1.0)) < 2.0e-10
    for k = 1:3
        subplot(3,1,k),  hold on,  plot(x,U,'r-'),  hold off
    end
end


    function z = left(y)
    z = [y(end) y(1:end-1)];

    function z = right(y)
    z = [y(2:end) y(1)];
