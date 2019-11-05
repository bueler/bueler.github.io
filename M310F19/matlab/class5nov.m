% CLASS5NOV  This is the show-and-tell I would have done if the
% projector had worked.

% function with large derivatives (e.g. 4th derivative has size 10^4)
f = @(x) x.^2 + 0.5 * sin(10*x);

% n+1=21 equally spaced points
n = 20;
x = linspace(-2,2,n+1);
y = f(x);

% fine grid for plotting
xx = -2:.001:2;

% show function (dotted) and piecewise-linear interpolant
figure(1)
L = interp1(x,y,xx,'linear');
% also try 'nearest' or 'previous' or 'next' ... do: >> help interp1
plot(xx,f(xx),':',xx,L,x,y,'ko')
legend('f(x)','L(x) piecewise-linear','data')
grid on,  axis tight,  xlabel x

% show function and 'spline','pchip' piecewise-cubic interpolants
figure(2)
Cpchip = interp1(x,y,xx,'pchip');
Cspline = interp1(x,y,xx,'spline');
% Cspline = spline(x,y,xx);       % same as above
plot(xx,f(xx),':',xx,Cpchip,xx,Cspline,x,y,'ko')
legend('f(x)','pchip (piecewise-cubic)','spline (piecewise-cubic)','data')
grid on,  axis tight,  xlabel x

