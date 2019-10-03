% CLASS3OCT   Example of putting a polynomial through points, done
% both with "hand-assembly" of A and using vander() and polyfit().

% the data
x = [1 2 3 5 7]';
y = [2 3 0 -1 1]';

% the matrix and right-hand side
A = [1.^(0:4); 2.^(0:4); 3.^(0:4); 5.^(0:4); 7.^(0:4)];
% alternative:  A = fliplr(vander(x));
b = y;

% the coefficients of the 4th-degree polynomial
c = A\b;

% plot the data and the polynomial
figure(1)
xf = -1:.01:8;  % need a fine grid for plotting
p = c(1) + c(2)*xf + c(3)*xf.^2 + c(4)*xf.^3 + c(5)*xf.^4;
plot(x,y,'o',xf,p)
axis([-1 8 -10 10]),  grid on,  xlabel x
legend('data','p_4(x)')

% new figure; do it again using built-in polynomial fitting
%   and polynomial evaluation tools
figure(2)
pp = polyfit(x,y,4);
plot(x,y,'o',xf,polyval(pp,xf))

