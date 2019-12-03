function [tt,yy] = rk4(f,trange,y0,n)
% RK4  Basic implementation of the classical fourth-order Runge-Kutta
% method.  Takes n equally-spaced steps of length h to solve
%   y' = f(t,y),  y(t0)=y0
% where y0 is a column vector, trange = [t0,t1], and h = (t1-t0)/n.
% Compare ODE45, which uses a pair of Runge-Kutta methods and can do
% adaptive time-stepping.
% Example 1:  solve  y'=-2y, y(0)=1  on [0,2]
%   >> f = @(t,y) -2*y;
%   >> [tt,yy] = rk4(f,[0,2],1,10);
%   >> plot(tt,yy)
%   >> yy(end), exp(-4)
% Example 2:  solve  van der Pol equations as on page 267 of
% Greenbaum & Chartier (2012)
%   >> f = @(t,y) [y(2); (1-y(1)^2)*y(2)-y(1)];
%   >> [tt,yy] = rk4(f,[0,20],[2;0],100);
%   >> subplot(2,1,1),  plot(tt,yy,'-o'),  title('rk4')
%   >> [ttt,yyy] = ode45(f,[0,20],[2;0]);
%   >> subplot(2,1,2),  plot(ttt,yyy,'-o'),  title('ode45')

if n <= 0,  error('number of steps must be positive');  end
h = (trange(2)-trange(1))/n;
tt = (trange(1):h:trange(2))';
yy = zeros(length(tt),length(y0));  % size follows ode45()
yy(1,:) = y0(:)';

% fourth-order Runge-Kutta from page 266 of Greenbaum & Chartier (2012)
for k = 1:length(tt)-1
    t = tt(k);
    q1 = f(t,yy(k,:)');
    q2 = f(t+h/2,yy(k,:)'+(h/2)*q1);
    q3 = f(t+h/2,yy(k,:)'+(h/2)*q2);
    q4 = f(t+h,yy(k,:)'+h*q3);
    yy(k+1,:) = yy(k,:) + (h/6) * (q1 + 2*q2 + 2*q3 + q4)';
end

