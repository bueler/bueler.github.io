% WOBBLY  demonstrate and plot Euler and midpoint methods on a
% simple, but slightly more interesting, ODE example

% a Newton's law of cooling example for a cup of coffee
% temperature in degrees F, time in minutes
room = @(t) 65.0 + 50.0 * cos(2*pi*t/5.0);
f = @(t,y) -0.069 * (y - room(t));
y0 = 142.0;

% do N steps of duration h
N = 20;
h = 1.0;

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

tfine = 0 : h/20 : N*h;
plot(tfine,room(tfine),'k')
axis([0 N*h 50 150])
legend('Euler approximation','midpoint approximation','room temperature')
hold off

