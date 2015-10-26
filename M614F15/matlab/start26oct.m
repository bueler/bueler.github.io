% START26OCT get going on L11 = least squares

% show the data
figure(1), clf
y = [1.7 1.2 0.5 0.3 1.2 1.5 1.1]'
x = [0.1 0.3 0.4 0.6 0.8 0.9 1.1]'
plot(x,y,'o')

% build a matrix
A = [ones(size(x)) cos(pi*x) cos(2*pi*x) cos(3*pi*x)]

% least squares fit [explain first]
[Q R] = qr(A,0)
c = R \ (Q'*y)

% show the fitted data
xfine = 0:.01:1.2;
figure(2), clf
plot(x,y,'o')
hold on
yfit = c(1) + c(2)*cos(pi*xfine) + c(3)*cos(2*pi*xfine) + c(4)*cos(3*pi*xfine);
plot(xfine,yfit,'r')
hold off

