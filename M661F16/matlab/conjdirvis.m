% CONJDIRVIS  Visualize an example of the ``conjugate directions'' method
% in n=2 dimensions. Uses
%    f(x) = (1/2) x' A x - b' x
% Requires:  CONJDIR

x = -5:.1:5;
y = x;
[xx, yy] = meshgrid(x,y);

% the problem:
A = [2 1; 1 1];
b = [0 0]';

% note:  f = x_1^2 + x_1 x_2 + 0.5 x_2^2
contour(xx,yy,xx.^2 + xx.*yy + 0.5*yy.^2,30,'k')  % 30 black contours
hold on

% columns of this P are conjugate (previous by-hand calculation); show as red
P = [1  1;
     0 -2];
plot([0 P(1,1)], [0, P(2,1)], 'r')
plot([0 P(1,2)], [0, P(2,2)], 'r')

x0 = [3 3]';
x = conjdir(x0,A,b,P);             % minimize using conjugate directions in P
plot(x(1,:),x(2,:),'bo-')          % show path of minimization

% label points
text(x0(1)+0.3, x0(2),'x_0', 'fontsize', 14)
text(x(1,2)+0.3, x(2,2)+0.3,'x_1', 'fontsize', 14)
text(x(1,3)+0.3, x(2,3)+0.3,'x_2', 'fontsize', 14)
text(P(1,1)+0.3, P(2,1),'p_0', 'fontsize', 14)
text(P(1,2)+0.3, P(2,2),'p_1', 'fontsize', 14)
hold off

