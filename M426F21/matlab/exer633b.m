% EXER633B  Solve Exercise 6.3.3 (b).  Calls EULERSYS.

n = 100;
f = @(t,u) [u(2); sin(2*t) - 9*u(1)];
[t,u] = eulersys(f, [0,2*pi], [2;1], n);
uexact = [0.2 * sin(3*t) + 2 * cos(3*t) + 0.2 * sin(2*t), ...
          0.6 * cos(3*t) - 6 * sin(3*t) + 0.4 * cos(2*t)];
err = abs(uexact - u);

subplot(2,1,1),  plot(t,u(:,1), t,u(:,2)),  axis tight
legend('y=u_1', 'dy/dt = u_2', 'location','northwest')
subplot(2,1,2), plot(t,err(:,1), t,err(:,2)),  axis tight
legend('error in u_1', 'error in u_2', 'location','northwest')
