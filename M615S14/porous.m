function [Uerr, dx, averr, maxerr] = porous(x,t0,tf)
% POROUS Solve the porous medium equation
%     u_t = (u^2 u_x)_x
% on an interval x using the t=t0 state of a Barenblatt solution
% (see BARENBLATT) as the initial condition and running till t=tf.
% Note that the t=tf state of the Barenblatt solution is the exact solution.
% Usage:
%   U = porous(x,t0,tf)
% takes grid x at input (assumed equally-spaced), initial time t0, and
% final time tf.  Returns approximate solution at final time, U ~ u(x,tf).
% Generates a figure showing solution and error at final time.  Computes
% and prints maximum and average error.
% Examples:  See GENPOROUSERRFIG and POROUSCONVERGEFIG.

U = barenblatt(x,t0,2);
figure,  clf,  plot(x,U,'k','linewidth',3.0),  hold on

dx = x(2) - x(1);   % we ASSUME x is equally-spaced
t = t0;
count = 0;
while t < tf
    % u and p at staggered locations
    Ustag = (U(2:end) + U(1:end-1)) / 2;
    p = Ustag.^2;
    % get dt
    dt = 0.5 * dx^2 / max(p);
    if t+dt > tf
      dt = tf - t;
    end
    % do step
    qstag = - p .* (U(2:end) - U(1:end-1)) / dx;
    U(2:end-1) = U(2:end-1) - dt * (qstag(2:end) - qstag(1:end-1)) / dx;
    % update time & counter
    t = t + dt;
    count = count + 1;
end

plot(x,U,'k','linewidth',3.0)
uexact = barenblatt(x,tf,2);
plot(x,uexact,'k--'),  hold off,  xlabel x

Uerr = abs(U-uexact);
averr = sum(Uerr) / length(Uerr);
maxerr = max(Uerr);

fprintf('porous RESULT on grid with  dx = %.3f, using %d steps in time:\n',...
        dx,count)
fprintf('  max     |U-uexact| = %.3e\n',maxerr)
fprintf('  average |U-uexact| = %.3e\n',averr)
