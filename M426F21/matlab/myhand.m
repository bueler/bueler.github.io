% MYHAND  Use cubic splines to draw a smooth outline of my hand.
% Also show the disaster from high-degree polynomial interpolation.
% (The condition number of the Vandermonde matrix is truely huge!)
% Finally show the coordinate functions x(t),y(t) of the curve.

% I put the origin in the lower left of the graph paper, so all
% coordinates were positive.  (Just a matter of convenience.)
xy = [21.1  0.3;
      23.1  3.2;
      26.0  7.1;
      28.0 13.2;
      29.0 17.1; % 5
      27.0 18.8;
      24.2 14.0;
      22.5 11.2;
      22.0 16.0;
      23.0 23.0; % 10
      23.2 29.0;
      20.2 30.0;
      19.7 26.0;
      18.8 22.0;
      17.6 17.7; % 15
      17.2 22.0;
      17.2 26.8;
      17.1 31.0;
      15.0 33.8;
      13.8 29.0; % 20
      13.6 25.0;
      13.6 21.0;
      13.3 18.2;
      12.9 23.0;
      12.4 28.0; % 25
      10.5 32.4;
       9.2 27.0;
       9.2 23.0;
       9.0 16.2;
       7.1 21.0; % 30
       5.9 26.0;
       4.4 26.1;
       3.9 21.0;
       5.8 14.0;
       6.2  8.0; % 35
       7.6  1.2];

% parameter axis
n = size(xy,1);
t = (1:n)';                              % data points:  t_k = k
tt = 1:.05:n;                            % for plotting

figure(1)  % cubic spline outline
sx = interp1(t,xy(:,1),tt,'spline');     % values of x(t)
sy = interp1(t,xy(:,2),tt,'spline');     % values of y(t)
plot(xy(:,1),xy(:,2),'ko', sx,sy,'k')    % plot data and interpolant
xlabel x,  ylabel y,  grid on
title('cubic spline')

figure(2)  % polynomial interpolation attempt
plot(xy(:,1),xy(:,2),'ko', sx,sy,'k'),  hold on
px = polyfit(t,xy(:,1),n-1);
py = polyfit(t,xy(:,2),n-1);
plot(polyval(px,t,tt),polyval(py,t,tt),'r:')
xlabel x,  ylabel y,  grid on,  hold off
title('polynomial interpolation explodes') 
axis([-15 50 -20 60])                    % back-out to show badness

figure(3)  % coordinate functions of parameterized curve
plot(tt,sx, tt,sy)
hold on
plot(t,xy(:,1),'k.','markersize',14, t,xy(:,2),'k.','markersize',14)
hold off
xlabel t,  legend('x(t)','y(t)')
