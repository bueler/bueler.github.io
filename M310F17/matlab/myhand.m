% MYHAND  Use cubic splines to draw a nice curved outline of my hand, based
% on a relatively-few samples.  (Also show the disasters from high-degree
% polynomial interpolation.)

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

n = size(xy,1) - 1;
t = 1:n+1;

tt = 1:.05:n+1;  % for plotting

figure(1)
ppsx = spline(t,xy(:,1));
ppsy = spline(t,xy(:,2));
plot(xy(:,1),xy(:,2),'ko', ...
     ppval(ppsx,tt),ppval(ppsy,tt),'k')
xlabel x, ylabel y, grid on
title('cubic spline')   % good

figure(2)
ax = npolyfit(t,xy(:,1),n);
ay = npolyfit(t,xy(:,2),n);
plot(xy(:,1),xy(:,2),'ko', ...
     npolyval(ax,t,tt),npolyval(ay,t,tt),'k')
xlabel x, ylabel y, grid on
title('polynomial (Newton form)')   % bad
axis([0 30 0 35])

figure(3)
ppx = polyfit(t,xy(:,1)',n);
ppy = polyfit(t,xy(:,2)',n);
plot(xy(:,1),xy(:,2),'ko', ...
     polyval(ppx,tt),polyval(ppy,tt),'k')
xlabel x, ylabel y, grid on
title('polynomial (Vandermonde form)')  % computational method fails
axis([0 30 0 35])

