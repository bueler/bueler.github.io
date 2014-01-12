t = 0:.1:4;
y5 = -(1/3)*exp(-4*t) + (4/3)*exp(-t);
y4 = exp(-2*t) .* (1+2*t);
y2 = exp(-t) .* ( cos(sqrt(3)*t) + (1/sqrt(3))*sin(sqrt(3)*t) );
plot(t,y5,'o-','markersize',12,...
     t,y4,'*-','markersize',12,...
     t,y2,'s-','markersize',12)
legend("b=5","b=4","b=2")
xlabel t, ylabel('y(t)')
grid on

