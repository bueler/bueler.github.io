% LFSQUARE  Generate the analog of Figure 4.6 in Morton & Mayers 2nd ed.
% using the Lax-Friedrichs scheme.  Compare UPWINDSQUARE, which actually
% reproduces Figure 4.6.

% velocity
a = @(x,t) (1 + x.^2) ./ (1 + 2*x.*t + 2*x.^2 + x.^4);
% initial condition
uinitial = @(x) (double(x >= 0.2) .* double(x <= 0.4));
% characteristic (needed when showing exact solution)
xstar = @(x,t) x - t ./ (1 + x.^2);

figure(1),  clf
xfine = 0:1/500:1;                           % use in plotting exact soln
dxchoice = [0.02 0.01];
tf = [0 0.1 0.5 1.0];
for k=1:2                                    % k=1 left col, k=2 right col
    dx = dxchoice(k);  x = 0:dx:1;
    dt = dx;  nu = dt / dx;
    for q=1:4                                % loop over final time (row)
        u = uinitial(x);
        t = 0:dt:tf(q);
        for n=1:length(t)-1
            an = a(x(2:end-1),t(n));           % values a(x_j,t_n); all positive
            unew = zeros(size(x));
            unew(2:end-1) = 0.5 * (u(1:end-2) + u(3:end)) - ...
                            0.5 * nu * an .* (u(3:end) - u(1:end-2));
            u = unew;
        end
        subplot(4,2, 2 * (q-1) + k)
        plot(xfine,uinitial(xstar(xfine,tf(q))),'k:'), hold on % exact soln
        plot(x,u,'ko-','markersize',2,'linewidth',1.0)         % numerical soln
        hold off,  axis off
        if q==1,  title(sprintf('dx = %.2f',dx)),  end
        if k==1,  xlabel(sprintf('               At t = %.1f',tf(q))),  end
    end
end
