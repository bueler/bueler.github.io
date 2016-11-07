% P20CD solution to a problem

J = [2, 2; exp(2), -1];
r = [1; 0.5*exp(2)-1];
p = J \ (-r);
phi = @(alpha) 0.5 * ( (1+p(1)*alpha).^2 + (1+p(2)*alpha).^2 - 1 ).^2 ...
             + 0.5 * ( 0.5 * exp(2*(1+p(1)*alpha)) - (1 + p(2)*alpha) ).^2;
alf = 0:.01:8;
plot(alf,phi(alf))
hold on
plot(1.0,phi(1.0),'ro')
hold off
grid on, xlabel('\alpha')

