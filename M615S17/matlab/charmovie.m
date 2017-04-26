% CHARMOVIE   Show movie of exact solution to advection problem
%    u_t + (1 - x) u_x = 0,  u(x,0) = sin(x)

x = -3:.02:3;
u = @(x,t) sin(1 - (1-x) * exp(t));
count = 0;
for t = 0:.01:3
  figure(1), clf
  plot(x,u(x,t),'k'),
  hold on, plot(1,sin(1),'k.','markersize',14), hold off   % show point is fixed
  title(sprintf('t = %.3f',t)),  xlabel x,  axis tight
  sleep(0.01)
end

