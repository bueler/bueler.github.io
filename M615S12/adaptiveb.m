function adaptiveb(J,tf)
% ADAPTIVEB  Solve a heat equation with variable diffusivity
%   u_t = b(x,t) u_xx
% using adaptive time-stepping.  Example:
%   >> adaptiveb(10,3);

dx = 1 / J;  x = 0:dx:1;
U = x.*(1-x);                   % fixed initial condition
% fixed b(x,t):
b = @(x,t) (1/30) * (2 + sin(4 * pi * x)) + 3 * exp(-30 * (t-2).^2);
maxn = 10000;                   % stop in any case if maxn steps
t = 0;   tlist = [t];           % store a list of times used

figure(1)                       % figure(1) will show movie
h = plot(x,U);  xlabel x,  ylabel U,  grid on
box = [0 1 0 0.6];  axis(box)

figure(2)                       % figure(2) will show t=0,1,2,3
plot(x,U,'b','linewidth',1.0);
xlabel x,  ylabel U,  grid on,  axis(box),  hold on

for n=1:maxn
  dt = dx * dx / (2 * max(b(x,t)));
  if t+dt > tf,  dt = tf - t;  end  % shorten if about done
  if (t<1) & (t+dt>=1)
    figure(2), plot(x,U,'r','linewidth',4.0), end
  if (t<2) & (t+dt>=2)
    figure(2), plot(x,U,'c','linewidth',6.0), end
  mu = dt / (dx * dx);
  U(2:J) = U(2:J) + mu * b(x(2:J),t) .* ...
                     (U(3:J+1) - 2 * U(2:J) + U(1:J-1)) + dt * (1/3);
  t = t+dt;  tlist = [tlist t]; % append list of times  t_n

  figure(1),  set(h,'YData',U)  % put it in the figure
  drawnow, axis(box), grid on   % refresh the figure
  title(sprintf('t = %8.5f',t)) % update t value in title
  pause(0.01)                   % make this (very roughly) 40 frames/sec
  
  if t >= tf, break, end        % normal exit when t=tf
  if n==maxn, warning('hit maximum number of time steps'), end
end

figure(2),  plot(x,U,'g','linewidth',10.0),  hold off
title('solution U at t=0 (blue), t=1 (red), t=2 (cyan), t=3 (green)')

figure(3),  plot(tlist(1:end-1),diff(tlist),'o')
xlabel('t_n'), ylabel('\Delta t_n')
