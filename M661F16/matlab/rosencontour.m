% ROSENCONTOUR  Draw contours of the Rosenbrock function

rosen = @(x1,x2) 100*(x2-x1.^2).^2 + (1-x1).^2;

x1 = 0:0.002:2;  x2 = x1;
[xx1,xx2] = meshgrid(x1,x2);

c = [0.05 0.2 1 4 2.^(3:10)];    % careful design of contour levels
contour(x1,x2,rosen(xx1,xx2),c,'k')
hold on,  plot(1,1,'ko','markersize',6),  hold off
xlabel('x_1'),  ylabel('x_2')
