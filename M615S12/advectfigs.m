function advectfigs(J,L)
% ADVECTFIGS  Reproduce Figure 4.8 in Morton & Mayers 2nd ed. using three
% three different schemes,
%   FIGURE   SCHEME
%     1        upwind version of Figure 4.8
%     2        Lax-Friedrichs version of Figure 4.8
%     3        Lax-Wendroff (true) version of Figure 4.8
% Form:  advectfigs(J,L)  where J is number of spatial subintervals
% in the left columns (the right column uses 2J) and L is length of x-axis.
% Uses CFL to determine the time step.
% Example:  >> advectfigs(50,1.0)

if nargin<2, L = 1.0;  end
if nargin<1, J = 50;   end

% need a function for a(x,t), which is always positive
a = @(x,t) (1 + x.^2) ./ (1 + 2*x.*t + 2*x.^2 + x.^4);
amax = 1;                              % because numerator <= denominator
nu0 = 1;                               % max dt allowed under CFL

% function for initial condition
uinitial = @(x) exp(-10 * (4 * x - 1).^2);
% needed when showing exact solution:
xstar    = @(x,t) x - t ./ (1 + x.^2);

% do three numerical schemes
xfine = 0:L/600:L;
tf = [0 0.1 0.5 1.0];
for fig=1:3
  for k=0:1                            % k=0 left column, k=1 right column
    dx = L / J;
    dt = nu0 * dx / amax;              % use CFL to find dt
    nu = dt/dx;                        % constant not using a(x,t)
    if k==1
      dx = dx/2;  dt = dt/2;           % ... but nu is same
    end
    x = 0:dx:L;
    for q=1:4                          % loop over final time (and figure row)
      u = uinitial(x);
      t = 0:dt:tf(q);
      for n=1:length(t)-1
        if fig==1                        % upwind
          an = a(x(2:end),t(n));         % values a(x_j,t_n)
          unew = zeros(size(x));
          unew(2:end) = u(2:end) - nu * an .* (u(2:end) - u(1:end-1));
          u = unew;
        end
        if fig==2                        % Lax-Friedrichs
          an = a(x(2:end-1),t(n));       % values a(x_j,t_n)
          unew = zeros(size(x));
          unew(2:end-1) = 0.5 * (u(1:end-2) + u(3:end)) - ...
                             0.5 * nu * an .* (u(3:end) - u(1:end-2));
          u = unew;
        end
        if fig==3                          % Lax-Wendroff combines L-F and leapfrog
          astag = a(x(1:end-1)+0.5*dx,t(n)); % values a(x_{j+1/2},t_n)
          ustag = 0.5 * (u(1:end-1) + u(2:end)) - ...
                    0.5 * nu * astag .* (u(2:end) - u(1:end-1));
          an = a(x(2:end-1),t(n)+dt/2);    % values a(x_j,t_{n+1/2})
          unew = zeros(size(x));
          unew(2:end-1) = u(2:end-1) - nu * an .* (ustag(2:end) - ustag(1:end-1));
          u = unew;
        end
      end
      figure(fig),  subplot(4,2, 2 * (q-1) + k + 1)
      plot(xfine,uinitial(xstar(xfine,tf(q))),'r')   % exact soln on fine grid
      hold on,  plot(x,u,'o-','markersize',6,'linewidth',1.0)    % numerical soln
      if q==1, title(sprintf('dx = %.2f',dx)), end
      if k==0, xlabel(sprintf('               at t = %.1f',tf(q))), end
      hold off,  axis off
    end
  end
end
