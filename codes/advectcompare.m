function advectcompare(m,tf,ic)
% ADVECTCOMPARE  Solve the scalar, constant-coefficient advection equation
%     u_t + a u_x = 0
% for u(x,t), with periodic boundary conditions on [0,1].  Choice of
% two initial conditions u(x,0): 'square' and 'hump'.  Uses m+1 grid points
% and a spatial grid with h = 1/(m+1).  If tf = 0 mod 1 then plots exact
% solution in red (after integer number of passes).  Compares two space-time
% discrete methods
%     upwind
%     Lax-Wendroff
% each subject to CFL.  Computes time-step k by version of CFL:
%     nu = a k / h = C    where C = .9 < 1
% Usage:  >> advectcompare(m,tf,ic)
% Examples:  >> advectcompare
%            >> advectcompare(100,2,'hump')

if nargin < 3,  ic = 'square';  end
if nargin < 2,  tf = 1.0;       end
if nargin < 1,  m = 20;         end

% generate space grid and time-step
a = 1.0;
h = 1.0 / (m+1);      % h = dx
x = 0:h:1.0-h;        % interpret as periodic grid
C = 0.9;              % use this Courant number
k = C * h / a;        % k = dt;  CFL says |a| k <= h
NN = ceil(tf / k);    % fix k so integer number of steps
printf('solving with dx = %.5f, dt = %.5f, and N = %d steps ...\n',h,k,NN)

% initial condition
if ic == 'square'
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
        Ulw = 0.5 * nu * (nu + 1.0) * left(Ulw) + (1.0 - nu^2) * Ulw ...
              + 0.5 * nu * (nu - 1.0) * right(Ulw);
    end
end

% plot numerical results
axisbox = [0.0 1.0 -0.3 1.3];
figure(1),  clf
subplot(2,1,1),  plot(x,Uup,'k-o'),  axis(axisbox),  grid on,  title('upwind')
subplot(2,1,2),  plot(x,Ulw,'k-o'),  axis(axisbox),  grid on,  title('Lax-Wendroff')

% add exact solution if appropriate
if abs(mod(tf + 1.0e-10,1.0)) < 2.0e-10
    xfine = linspace(0,1,1001);
    if ic == 'square'
        Ufine = ones(size(xfine));  Ufine(xfine < 0.4) = 0.0;  Ufine(xfine > 0.6) = 0.0;
    else
        Ufine = sin(pi * xfine).^20;
    end
    for k = 1:2
        subplot(2,1,k),  hold on,  plot(xfine,Ufine,'r-'),  hold off
    end
end

    function z = left(y)
    z = [y(end) y(1:end-1)];
    end

    function z = right(y)
    z = [y(2:end) y(1)];
    end

end % function
