function stiffexample(n)
% STIFFEXAMPLE  Does n steps of fourth-order Runge-Kutta on a stiff ODE system
%    x' = -1000 x + y
%    y' = 0 x - (1/10) y
%    x(0) = 1,  y(0) = 2
% Calls RK4.

f = @(t,y) [-1000*y(1)+y(2); -0.1*y(2)];
[tt,yy] = rk4(f,[0,1],[1;2],n);

xexact = (9979/9999)*exp(-1000*tt) + (20/9999)*exp(-tt/10);
yexact = 2*exp(-tt/10);
% compare values at t=1:  [xexact(end); yexact(end)]  versus   yy(:,end)

figure(1)
plot(tt,xexact,tt,yexact)
title('exact'),  xlabel t,  legend('x(t)','y(t)')

figure(2)
yy(abs(yy)>100) = 100;  % hide extreme blowup
plot(tt,yy)
if max(max(yy)) > 2
    axis([0 1 0 max(max(yy))-1])
end
title(sprintf('rk4 with n=%d',n)),  xlabel t,  legend('x(t)','y(t)')

