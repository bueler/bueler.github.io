% EULERMIDPOINT  demonstrate and plot Euler and midpoint methods on a
% simple ODE example

% a Newton's law of cooling example for a cup of coffee
% temperature in degrees F, time in minutes
f = @(t,y) -0.069 * (y - 65.0);
y0 = 142.0;

% do N steps of duration h
N = 6;
h = 5.0;

% Euler approximation
t = 0 : h : N*h;
yE = zeros(size(t));
yE(1) = y0;
for k = 1:N
  yE(k+1) = yE(k) + h * f(t(k),yE(k));
end
set(0,'defaultlinelinewidth',2.0)
plot(t,yE,'o-','markersize',14)

% midpoint approximation
yM = zeros(size(t));
yM(1) = y0;
for k = 1:N
  yhalf = yM(k) + (h/2) * f(t(k),yM(k));
  yM(k+1) = yM(k) + h * f(t(k)+h/2,yhalf);
end
hold on, plot(t,yM,'g*-','markersize',14)

% exact solution
tfine = 0 : h/10 : N*h;
yexact = 65.0 + (y0 - 65.0) * exp(-0.069 * tfine);
hold on, plot(tfine,yexact,'r')

legend('Euler approximation','midpoint approximation','exact')
hold off

