function showlms(u,L)
% SHOWLMS  Plot the state of the linear mass-spring system.  Input u
% is displacement of the N free masses where N = length(u).  Input L
% is total length.  For example,
%   >> showlms([-0.1 0.1 -0.1 -0.2],2.0)
% This function is called by LMS.

N = length(u);         % number of free masses
dx = L / (N + 1);
xe = dx:dx:L-dx;       % equilibrium (spring relaxed) locations of masses
x = u + xe;            % locations of masses
xx = [0 x L];        % locations of masses including endpoints

% show masses as big dots
plot(x,zeros(size(u)),'ko','markersize',14)
hold on

% show fixed end blocks
d = L/40;
z = L/30;
fill([-d 0 0 -d -d], [-z -z z z -z], 'k')
fill(L+d+[-d 0 0 -d -d], [-z -z z z -z], 'k')

% show springs
ms = 101;              % points to plot in a spring
ps = 4;                % number of bumps per spring
xs = linspace(0,1,ms);
ys = (L/100) * abs(sin(2*pi*ps*xs)) - (L/200);
for j = 1:N+1
  lspring = xx(j+1) - xx(j);  % length of spring
  plot(xx(j) + lspring * xs,ys,'k-','linewidth',1.0)
end

% show axis and ticks for equilibrium locations
plot([0 L],[-3*z -3*z],'k','linewidth',2.0)
for j = 1:N
  plot([xe(j) xe(j)],[-2.7*z,-3.3*z],'k','linewidth',2.0)
end
hold off
axis([-2*d L+2*d -L/5 L/5])
axis off
