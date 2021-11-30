% LOGISTICS  Plot several solutions of a logistic equation.  Solves
% Exercise 6.1.5 in Driscoll & Braun.

k = 1;  S = 1;  M = 0.25;
f = @(t,x) k * (S - x) .* (x - M);
x0 = [0.9*M, 1.1*M, 1.5*M, 0.9*S, 1.1*S, 3*S];
for k = 1:6
    [t, x ] = ode45(f, [0, 10], x0(k));
    plot(t, x),  hold on
end
plot([0, 10], [S, S], 'k--', [0, 10], [M, M], 'k--')
hold off
legend('x0 = 0.9 M', 'x0 = 1.1 M', 'x0 = 1.5 M', ...
       'x0 = 0.9 S', 'x0 = 1.1 S', 'x0 = 3 S')
axis([0 10 0 3.5]),  xlabel t,  ylabel('x(t)')
