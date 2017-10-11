% CLASS10OCT  Edited transcript of in-class Matlab/Octave session on polynomial
% interpolation, starting to focus on "how good" questions rather than "how to".
% Also shows how to use POLYFIT, POLYVAL, PLOT, AXIS, LEGEND, and TITLE.

% start with interpolating a rational function at 4 points (n=3)
f = @(x) x + 1 ./ x;
xi = [0.5 1 2 5];
p3 = polyfit(xi,f(xi),3);    % we don't even need to see these coefficients
                             %    if we just want to plot, as below

% plot, in turn:  y=f(x), y=p(x), (xi,yi)
x = 0:.01:7;
figure(1)
plot(x,f(x),x,polyval(p3,x),xi,f(xi),'o')
legend('y=f(x)','y=p_3(x)','data (x_i,y_i)')
axis([0 7 0 10])

% add more interpolation points and plot again
xi = [0.5 1 2 3 4 5];       % n+1=6 points  ...  so n = 5
p5 = polyfit(xi,f(xi),5);
figure(2)
plot(x,f(x),x,polyval(p5,x),xi,f(xi),'o')
legend('y=f(x)','y=p_5(x)','data (x_i,y_i)')
axis([0 7 0 10])

% now plot error  |f(x) - p_5(x)|
figure(3)
plot(x,abs(f(x)-polyval(p5,x)))
title('error |f(x)-p_5(x)|')
axis([0.5 5 0 0.1])
% Note error is large in [0.5,1], where f(x) curves a lot, even though the
% spacing between points x_i is smallest there.  We will see that the polynomial
% interpolation error theorem (section 4.3) says the error is large
% when the 6th derivative of f(x) is large (in this case).

