% NONLINSHOW   Numerically solve the ODE IVP
%   u'' + u^3 = 0,  u(0) = 1,  u'(0) = A
% for a range of A values, to illustrate shooting.  The goal
% is to get u(1) = -2.  Uses ODE45.

% ODE as a system is:   u' = v,  v' = -u^3   or  Y' = G(Y)
G = @(x,Y) [Y(2); -Y(1).^3];

AA = -5:1:5;  % list the A values
x = 0:0.01:1;

for j = 1:length(AA)
  [xout, Y] = ode45(G,x,[1.0; AA(j)]);
  plot(x,Y(:,1)'),   hold on
  text(1.0,Y(end,1),sprintf('  A=%.2f',AA(j)))
end
grid on,  xlabel x,  ylabel y,  hold off
