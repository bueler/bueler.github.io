% NOTCIRCLES  Draw the unit "circles" in infty-norm and 1-norm.

subplot(1,2,1)
plot([1 -1 -1 1 1], [1 1 -1 -1 1])
grid on,  axis equal,  axis([-1.5 1.5 -1.5 1.5])
xlabel('x_1'),  ylabel('x_2')
title('unit "circle" for infinity-norm')

subplot(1,2,2)
plot([1 0 -1 0 1], [0 1 0 -1 0])
grid on,  axis equal,  axis([-1.5 1.5 -1.5 1.5])
xlabel('x_1'),  ylabel('x_2')
title('unit "circle" for 1-norm')
