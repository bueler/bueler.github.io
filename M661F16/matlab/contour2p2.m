% CONTOUR2P2  Draw contours of the function f(x) given in problem 2.2

f = @(x1,x2) 8*x1 + 12*x2 + x1.^2 - 2 * x2.^2;
x1 = -10:0.05:0;
x2 = 0:0.05:7;
[xx1,xx2] = meshgrid(x1,x2);
contour(x1,x2,f(xx1,xx2),20,'k')
hold on,  plot(-4,3,'ko','markersize',6)
text(-3.7,3.3,'x^*','color','k','fontsize',14),  hold off
xlabel('x_1'),  ylabel('x_2')
