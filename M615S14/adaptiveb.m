function adaptiveb(J,tf)
% ADAPTIVEB  Solve a heat equation with variable diffusivity
%   u_t = b(x,t) u_xx + C
% using adaptive time-stepping, where b(x,t), C=1/3, the domain, and
% the initial conditions are all hard-coded.
% Usage:
%   adaptive(J,tf)
% uses J spatial grid points.  tf is a vector of times at which to
% report; the run starts at t=0 and ends at t=tf(end).
% Example:
%   >> adaptiveb(10,[1 2 3]);

dx = 1 / J;  x = 0:dx:1;
U = x.*(1-x);                   % fixed initial condition

% fixed b(x,t):
b = @(x,t) (1/30) * (2 + sin(4 * pi * x)) + 3 * exp(-30 * (t-2).^2);
maxn = 100000;                  % stop in any case if maxn steps
t = 0;
tlist = [t];                    % start a list of the time steps we took

figure(1)                       % figure(1) will show movie
h = plot(x,U);  xlabel x,  ylabel U,  grid on
box = [0 1 0 0.6];  axis(box)

figure(2)                       % figure(2) will show t=0,tf(1),...
plot(x,U,'b','linewidth',2.0);
xlabel x,  ylabel U,  grid on,  axis(box)
hold on

indtf = 1;                      % current goal is tf(indtf)
for n=1:maxn                    % because of "break" below, this is like
                                % a "while" loop, but protected: not infinite
  if t >= tf(end),  break,  end % normal exit
  % first show current solution if we are at a tf
  if abs(t - tf(indtf)) < 1.0e-10
    figure(2),  plot(x,U,'linewidth',2.0)
  end
  % now compute stable dt
  dt = dx * dx / (2 * max(b(x,t)));  % so  (dt/dx^2) (max_j b(x_j,t_n)) = 1/2
  if t+dt >= tf(indtf)
    dt = tf(indtf) - t;         % shorten if arriving at a tf
    indtf = indtf+1;
  end
  % now take one step of explicit scheme
  mu = dt / (dx * dx);
  U(2:J) = U(2:J) + mu * b(x(2:J),t) .* ...
                     (U(3:J+1) - 2 * U(2:J) + U(1:J-1)) + dt * (1/3);
  t = t + dt;
  tlist = [tlist t];
  % movie frame
  figure(1),  set(h,'YData',U)  % put it in the figure
  drawnow, axis(box), grid on   % refresh the figure
  title(sprintf('t = %8.5f',t)) % update t value in title
  pause(0.01)                   % make this (very roughly) 40 frames/sec
end
if n >= maxn, warning('hit maximum number of time steps'), end

figure(2),  plot(x,U,'linewidth',6.0),  hold off
title('solution U at t=0, t=1, t=2, and t=3 (thicker)')

figure(3),  plot(tlist(1:end-1),diff(tlist),'o')
xlabel('t_n'), ylabel('\Delta t_n')
