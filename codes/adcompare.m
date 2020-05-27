function adcompare(m,tf,ic)
% ADCOMPARE  Solve the scalar, constant-coefficient advection equation
%     u_t + a u_x = 0
% for u(t,x), with periodic boundary conditions on [0,1] and speed a = 1.
% Choice of two initial conditions u(0,x): 'square' and 'hump'.  Uses m
% grid points and equal spacing with dx = 1/m.  If tf is an integer then
% exact solution is the initial condition, because an integer number of
% cycles have occurred.  In that case the initial condition is plotted in
% red. Compares two space-time discrete methods
%     upwind
%     Lax-Wendroff
% each subject to CFL.  Computes time-step dt from dx and a by using CFL:
%     a dt / dx = C
% where C = .9 < 1.
% Examples:  >> adcompare
%            >> adcompare(100,2,'hump')

if nargin < 3,  ic = 'square';  end
if nargin < 2,  tf = 1.0;       end
if nargin < 1,  m = 20;         end

% generate space grid and time-step
a = 1.0;              % speed
h = 1.0 / m;          % h = dx
x = h/2:h:1.0-h/2;    % cell-centered periodic grid
C = 0.9;              % use this Courant number
dt = C * h / a;       % CFL says |a| dt <= dx
NN = ceil(tf / dt);   % integer number of steps
dt = tf / NN;         % now we will hit tf exactly
printf('solving with dx = %.5f, dt = %.5f, and N = %d steps to tf=%.3f ...\n',...
       h,dt,NN,tf);

% initial condition
if strcmp(ic,'square')
    U = ones(size(x));  U(x < 0.4) = 0.0;  U(x > 0.6) = 0.0;
else
    U = sin(pi * x).^20;
end

% solve advection equation by upwind and Lax-Wendroff
Uup = U;  Ulw = U;
if NN > 0
    nu = a * dt / h;
    for n = 1:NN
        Uup = (1.0 - nu) * Uup + nu * left(Uup);
        Ulw = 0.5 * nu * (nu + 1.0) * left(Ulw) + (1.0 - nu^2) * Ulw ...
              + 0.5 * nu * (nu - 1.0) * right(Ulw);
    end
end

% plot numerical results
axisbox = [0.0 1.0 -0.3 1.3];
meth = {'upwind','Lax-Wendroff'};
figure(1),  clf
subplot(2,1,1),  plot(x,Uup,'k-o'),  axis(axisbox),  grid on,  title(meth{1})
subplot(2,1,2),  plot(x,Ulw,'k-o'),  axis(axisbox),  grid on,  title(meth{2})

% show exact solution if possible, and compute error norm
if abs(mod(tf + 1.0e-10,1.0)) < 2.0e-10   % did we wrap an integer number of times?
    % L^1 error norm by midpoint rule
    err(1) = sum(abs(Uup - U)) * h;
    err(2) = sum(abs(Ulw - U)) * h;
    % compute exact solution on fine grid for plotting
    xfine = linspace(0,1,1001);
    if strcmp(ic,'square')
        Ufine = ones(size(xfine));  Ufine(xfine < 0.4) = 0.0;  Ufine(xfine > 0.6) = 0.0;
    else
        Ufine = sin(pi * xfine).^20;
    end
    % print and plot
    for k = 1:2
        printf('%s L^1 error norm = %.3e\n',meth{k},err(k))
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

