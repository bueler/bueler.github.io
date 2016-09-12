% CONTOUREXAMPLE   Show contour plot of example in class used for illustrating
% Taylor's Theorem.

f = @(x,y) x.^3/3 - 2*x.*y + 5*x + y.^2 - 2*y;

x = -5:.1:5;
y = -2:.1:6;
[xx,yy] = meshgrid(x,y);

contour(x,y,f(xx,yy),30,'k')
hold on 
plot(1,3,'ko')
text(1,3+0.5,'x')
plot(1-2,3+0,'k*')
text(1-2,3+0+0.5,'x+p')
hold off

print -dpdf contourexample.pdf

