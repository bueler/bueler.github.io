function fourballs
% there is more than one way to make a 4-ball: some solutions

subplot(2,4,1)
  t = -1:2/40:1;  % higher res crashes my Matlab; Octave is o.k. w 500
  [x,y] = meshgrid(t,t);
  spy(x.^4+y.^4 < 1)
  axis equal,  axis off

subplot(2,4,2)
  x = -1:0.01:1;
  scatter(x,(1-x.^4).^0.25);  hold,  scatter(x,-(1-x.^4).^0.25);
  makeaxes,  hold off,  axis equal,  axis off

subplot(2,4,3)
  x = -(-128:128)/128;  y = (ones(1,257)-x.^4).^0.25;
  area(x,y);  hold,  area(x,-y);
  makeaxes,  hold off,  axis equal,  axis off

subplot(2,4,4)
  x = -1:.01:1;
  fill(x,(1-x.^4).^(1/4),'k'),  hold,  fill(x,-(1-x.^4).^(1/4),'k')
  makeaxes,  hold off,  axis equal,  axis off

subplot(2,4,5)
  t = -1:2/500:1;  [x,y] = meshgrid(t,t);
  contourf(x,y,x.^4+y.^4,1)
  makeaxes,  axis equal,  axis off

subplot(2,4,6)
  for i=1:100  % my Matlab crashes with 1000 points; Octave is fine
    x = randn(2,1);  x = x/norm(x,4);
    plot(x(1),x(2),'.');  hold on
  end
  makeaxes,  hold off,  axis equal,  axis off

subplot(2,4,7)
  x = repmat(-1:0.01:1,201,1);  f = @(x,y)(x.^4+y.^4);
  contour(f(x,x'),1)
  axis equal,  axis off

subplot(2,4,8),  text(0,0,'any others?'),  axis equal,  axis off
  
  function makeaxes
    hold on
    plot([-1.5 1.5], [0 0], 'k'),  plot([0 0], [-1.4 1.4], 'k')
    hold off
  end

end
