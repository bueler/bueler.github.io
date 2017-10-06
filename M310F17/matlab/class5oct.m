% CLASS5OCT  Edited transcript of what I did in class on Thursday 5 October.
% This relates to sections 4.1 and 4.2.  I show various manipulations to do
% polynomial interpolation.

% the points themselves are (x_i,y_i)
xi = [0.5 1.0 2.0 5.0];
yi = [2.5 2.0 2.5 5.2];

% Vandermonde method seeks p(x) = c_0 + c_1 x + c_2 x^2 + c_3 x^3
A = [1 0.5 0.25 0.125;
     1   1    1     1;
     1   2    4     8;
     1   5   25   125];
% same: A = fliplr(vander(xi))
b = [2.5 2.0 2.5 5.2]';
% same: b = [2.5; 2; 2.5; 5.2]
% same: b = yi'
c = A \ b

% plot data points and p(x)
x = -1:.001:6;
y = c(1) + c(2) * x + c(3) * x.^2 + c(4) * x.^3;  % Matlab indices start at 1
figure(1)
plot(xi,yi,'o',x,y)
title('p(x) and nodes (x_i,y_i)')
xlabel x,  ylabel y,  grid on

% build and plot third Lagrange polynomial:
L3 = (x-0.5) .* (x-1) .* (x-2) / ((5-0.5)*(5-1)*(5-2));
figure(2)
plot(xi,[0 0 0 1],'o',x,L3)
title('L_3(x)')
axis([-1 6 -0.1 1.1])
xlabel x,  grid on

% compute p(x) by Newton form:
%     p(x) = a_0 + a_1 (x-x_0) + a_2 (x-x_0) (x-x_1) + a_3 (x-x_0) (x-x_1) (x-x_2)
A = [1   0   0   0;     % A is lower triangular
     1 0.5   0   0;
     1 1.5 1.5   0;
     1 4.5  18  54];
b = [2.5 2 2.5 5.2]';   % same as before
a = A \ b

% use built-in method to get coefficients of p(x), and plot
c = polyfit(xi,yi,3)
% coefficients in same order as earlier:  c = fliplr(polyfit(xi,yi,3))
x = -1:.001:6;
y = polyval(c,x);  % this is p(x)
figure(3)
plot(xi,yi,'o',x,y)
title('p(x) and nodes (x_i,y_i)')
xlabel x,  ylabel y,  grid on

