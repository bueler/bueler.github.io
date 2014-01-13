% ELEVENFIGS  Reproduce Figures 11.1 and 11.2 from Trefethen & Bau.
x = -5:5;  y = [0 0 0 1 1 1 0 0 0 0 0];    % data
xfine = -5.5:.005:5.5;                     % fine grid for plotting
for n = 1:2
  figure(n),  plot(x,y,'kx','markersize',10),  hold on
  plot([0 0],[-2 5],'k',[-6 6],[0 0],'k')  % axes
  if n == 1,   p = polyfit(x,y,10);        % hit data exactly
  else,        p = polyfit(x,y,7);   end   % fit data smoother
  plot(xfine, polyval(p, xfine), 'k'),  hold off
  if n == 1,  axis([-6.5 6.5 -2 5])
  else,       axis([-6.5 6.5 -2 3]),   end
  axis off
end
