% SHOWNONLOCAL  show that modifying the piecewise-linear interpolant is local
% but that modifying the cubic spline is nonlocal

x=0:6;
y=randn(1,7);

% show the intepolation points (nodes)
figure(1), clf      % clear out figure 1
plot(x,y,'ko','markersize',14)

% show both  l(x)  and  s(x)
xx=0:.01:6;
hold on
plot(xx,interp1(x,y,xx,'linear'),xx,interp1(x,y,xx,'spline'))

% now move one point and show results
y(3)=y(3)+1;  plot(x(3),y(3),'k*','markersize',14)
plot(xx,interp1(x,y,xx,'linear'),'b',xx,interp1(x,y,xx,'spline'),'r')
hold off
title('old spline = green,  new spline = red,  piecewise-linear in blue')
