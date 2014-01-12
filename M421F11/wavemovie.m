% WAVEMOVIE  Make a movie out of a D'Alembert solution to the wave equation.
% D'Alembert says
%   u(x,t) = F(x-c*t) + G(x+c*t)
% solves
%   u_tt = c^2 u_xx
% The method for making a movie is the most portable I can make.  It should 
% work in both octave and matlab.

c = 1;                    % speed = 1
G = @(x) exp(-abs(x));    % a single peak
F = @(x) 0.2*sin(x);      % a simple wave

% plot movie
figure(1)
x = -15:0.05:15;          % fine grid of 400 points
u = F(x-c*0) + G(x+c*0);  % use t=0 for first frame
h = plot(x,u);            % use plot for first frame; get handle
xlabel x, ylabel u, grid on
box = [-15 15 -0.5 1.3];  axis(box)
for t=0:0.1:25
  u = F(x-c*t) + G(x+c*t);      % compute u for new frame
  set(h,'YData',u)              % put it in the figure
  drawnow, axis(box), grid on   % refresh the figure
  title(sprintf('t = %4.2f',t)) % update t value in title
  pause(0.05)                   % make this (very roughly) 20 frames/sec
end

