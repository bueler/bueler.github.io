% SCRIPTDV  Use splines to draw parameterized font letters.
% See Exercise 16 in Chapter 8 of Greenbaum & Chartier.
% The left subfigure shows the "D" draw by part (a) and the
% right subfigure shows the "V" which I created for part (d).

for side = 1:2
  if side == 1  % left  side of Figure 1
    x = [3.00 1.75 0.90 0.00 0.50 1.50 3.25 4.25 4.25 3.00 3.75 6.00];
    y = [4.00 1.60 0.50 0.00 1.00 0.50 0.50 2.25 4.00 4.00 3.25 4.25];
  else          % right side of Figure 1
    x = [1.0 0.7 0.7 1.2 1.3 1.5 1.8 2.4 2.7 2.8 3.2];
    y = [3.5 3.0 4.0 3.5 1.5 0.5 0.0 0.5 1.5 3.5 3.8];
  end
  n = length(x);
  t = 0:n-1;
  tt = 0:0.01:n-1;  % finer mesh to sample and show spline
  subplot(1,2,side)
  xx = spline(t,x,tt);   yy = spline(t,y,tt);
  % initial size letter is blue
  plot(xx,yy,'LineWidth',2),  hold on
  plot(x,y,'o','MarkerSize',10)
  % double size letter is red
  plot(2*xx,2*yy,'r','LineWidth',3)
  plot(2*x,2*y,'ro','MarkerSize',12)
  grid on, xlabel x, ylabel y, hold off
end

figure(1)
set(gcf,'PaperOrientation','landscape','PaperPositionMode','auto')
set(gcf,'Position',[300  200 1000 420])  % force it to be wide
print -depsc scriptDV.eps   % print to file for inclusion in document
