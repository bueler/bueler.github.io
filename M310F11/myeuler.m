function myeuler(f,t0,y0,tf,N)
% MYEULER solve ODE IVP
%    y' = f(t,y),   y(t0) = y0
% on the interval [t0,tf] with N subintervals
% usage:
%    >> myeuler(f,t0,y0,tf,N)

t = linspace(t0,tf,N+1);
h = t(2) - t(1);
y = zeros(size(t));
y(1) = y0;
for n=1:N
  y(n+1) = y(n) + h * f(t(n),y(n));
end

plot(t,y,'o','markersize',12)
xlabel t, ylabel y, grid on
  
