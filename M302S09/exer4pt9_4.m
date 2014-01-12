%% produce "sketch" for exercise #4 in section 4.9
t = 0:.02:1.2;
y0 = cos(8*t);
y10 = exp(-5*t) .* ( cos(sqrt(39)*t) + (5/sqrt(39))*sin(sqrt(39)*t) );
y16 = exp(-8*t) .* ( ones(size(t)) + 8 * t );
y20 = (4/3) * exp(-4*t) - (1/3) * exp(-16*t);
plot(t,y0,'o-','markersize',12,t,y10,'*-','markersize',12,...
     t,y16,'s-','markersize',12,t,y20,'d-','markersize',12)
legend("b=0","b=10","b=16","b=20")
xlabel t, ylabel('y(t)'), grid on

