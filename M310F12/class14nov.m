% CLASS14NOV  In-class session showing polynomial interpolants.

% Example 1:  f(x) = sin(x),  [a,b]=[0,pi],  equally-spaced

% From previous class we have
%     |f(x) - p(x)| <= pi^(n+1) / (n+1)!
% We want |f(x) - p(x)| < 10^-6.

% find n
format short e
n = 5;  pi^(n+1) / factorial(n+1)
n = 10;  pi^(n+1) / factorial(n+1)
n = 10;  pi^(n+1) / factorial(n+1)
n = 15;  pi^(n+1) / factorial(n+1)  % almost
n = 20;  pi^(n+1) / factorial(n+1)  % too far
n = 16;  pi^(n+1) / factorial(n+1)  % got it: < 10^-6

% plot the poly
x = 0:pi/n:pi;
p = polyfit(x,sin(x),n);
xfine = 0:pi/2000:pi;
figure(1)
plot(x,sin(x),'r*',xfine,sin(xfine),xfine,polyval(p,xfine))
grid on,  axis tight
legend('interpolation points','f(x)=sin(x)','p(x)')
title('equally-spaced interpolation of sin(x) succeeds')

% evaluate quality
norm(sin(x) - polyval(p,x),'inf')          % should be zero
norm(sin(xfine) - polyval(p,xfine),'inf')  % should be less than 10^-6
% from these we see we were too conservative; a smaller n should do

% find the first n where the measured error is less than 10^-6:
format short
n = 15
x = 0:pi/n:pi;  p = polyfit(x,sin(x),n);
norm(sin(xfine) - polyval(p,xfine),'inf')
n = 8
x = 0:pi/n:pi;  p = polyfit(x,sin(x),n);
norm(sin(xfine) - polyval(p,xfine),'inf')


% Example 2:  f(t) = 1 / (1 + 25 t^2),  [a,b]=[-1,1],  equally-spaced
% f(t) is called the Runge function

n = 4;  t = -1:2/n:1;
figure(2)
tfine=-1:1/500:1;
plot(tfine,1./(1+25*tfine.^2))
hold on
% to show interpolation pts:
% plot(t,1./(1+25*t.^2),'r*','markersize',16)
p = polyfit(t,1./(1+25*t.^2),n);
plot(tfine,polyval(p,tfine),'g')
n = 10;  t = -1:2/n:1;  p = polyfit(t,1./(1+25*t.^2),n);
plot(tfine,polyval(p,tfine),'r')
n = 20;  t = -1:2/n:1;  p = polyfit(t,1./(1+25*t.^2),n);
plot(tfine,polyval(p,tfine),'c')
%n = 40;  t = -1:2/n:1;  p = polyfit(t,1./(1+25*t.^2),n);
%plot(tfine,polyval(p,tfine),'k')
axis([-1.2 1.2 -0.2 1.2])
legend('f(t)=1/(1+25 t^2)','p(x) with n=4','p(x) with n=10','p(x) with n=20')
title('equally-spaced interpolation of the Runge function is BAD')
hold off


% Example 3:  f(t) = 1 / (1 + 25 t^2),  [a,b]=[-1,1],  Chebyshev points
% t_j = cos(j pi/n),  j=0,1,...,n  are the Chebyshev points

figure(3)
plot(tfine,1./(1+25*tfine.^2)),  hold on
n = 4;  t = cos((0:n)*pi/n);  p = polyfit(t,1./(1+25*t.^2),n);
plot(tfine,polyval(p,tfine),'g')
n = 10;  t = cos((0:n)*pi/n);  p = polyfit(t,1./(1+25*t.^2),n);
plot(tfine,polyval(p,tfine),'r')
n = 20;  t = cos((0:n)*pi/n);  p = polyfit(t,1./(1+25*t.^2),n);
plot(tfine,polyval(p,tfine),'c')
axis([-1.2 1.2 -0.2 1.2])
legend('f(t)=1/(1+25 t^2)','p(x) with n=4','p(x) with n=10','p(x) with n=20')
title('Chebyshev point interpolation of the Runge function is GOOD')
hold off

