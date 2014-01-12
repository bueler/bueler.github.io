% COMPAREHEAT  Show solutions to E1(a) and E1(b) on final exam.

set(0,'defaultlinelinewidth',3.0)
L = 3;
x = 0:.01:L;
for t=10.^(-3:.1:2)
  % part (a)
  ua = ((1-exp(-L)) / L) * ones(size(x));
  sign = 1;
  for n=1:40
    sign = - sign;
    c = 2 * L * (1 - sign * exp(-L)) / (pi^2 * n^2 + L^2);
    ua = ua + c * exp(- n^2 * pi^2 * t / L^2) * cos(pi*n*x/L);
  end
  % part (b)
  z = x / (2*sqrt(t));
  ub = (1/2) * ( exp(t+x) .* erfc(z+sqrt(t)) ...
                 + exp(t-x) .* erfc(-z+sqrt(t)) );
  plot(x,exp(-x),x,ua,x,ub), xlabel x
  legend('u(x,0) in (a) and (b)','u_a(x,t)','u_b(x,t)')
  title(sprintf('t=%f',t))
  pause(0.4)
end

