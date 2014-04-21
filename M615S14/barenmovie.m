% BARENMOVIE calls BARENBLATT to generate a movie

u0 = 2.0;
x = linspace(-10,10,400);
t = linspace(0.1,10,100);          % compare:  t = 10.^linspace(-1,1,100);

u = barenblatt(x,t(1),u0);
figure,  h = plot(x,u);            % get handle
box = [-10 10 -0.5 4];  axis(box),   grid on
for n=1:length(t)
  u = barenblatt(x,t(n),u0);
  set(h,'YData',u)                 % use handle to change the content, and
  drawnow,  axis(box),  grid on    % ... refresh the figure
  title(sprintf('t = %8.5f',t(n))) % put t value in title
  pause(0.02)                      % makes this (very roughly) 20 frames/sec
end
