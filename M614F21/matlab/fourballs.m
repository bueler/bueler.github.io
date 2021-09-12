% FOURBALLS  there is more than one way to make a 4-ball!

subplot(3,2,1)
  t = -1:2/50:1;
  [x,y] = meshgrid(t,t);
  spy(x.^4+y.^4 < 1)
  axis equal,  axis off

subplot(3,2,2)
  x = -1:0.01:1;
  scatter(x,(1-x.^4).^0.25);
  hold on,  scatter(x,-(1-x.^4).^0.25);
  hold off,  axis equal,  axis off

subplot(3,2,3)
  x = -(-128:128)/128;  y = (ones(1,257)-x.^4).^0.25;
  area(x,y);  hold on,  area(x,-y);
  hold off,  axis equal,  axis off

subplot(3,2,4)
  x = -1:.01:1;
  fill(x,(1-x.^4).^(1/4),'k'),
  hold on,  fill(x,-(1-x.^4).^(1/4),'k')
  hold off,  axis equal,  axis off

subplot(3,2,5)
  t = -1:2/100:1;  [x,y] = meshgrid(t,t);
  contourf(x,y,x.^4+y.^4,1)
  axis equal,  axis off

subplot(3,2,6)
  for i=1:200
    x = randn(2,1);  x = x/norm(x,4);
    plot(x(1),x(2),'.');  hold on
  end
  hold off,  axis equal,  axis off
