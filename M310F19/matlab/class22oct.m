% CLASS22OCT   Solve polynomial interpolation and least squares fit problems.

% generate and show 6 data points
x = rand(1,6);
y = randn(1,6)'
plot(x,y,'o');

% form the Vandermonde matrix and compute coefficients
format short g
A = fliplr(vander(x))
c = A\y

% plot the resulting polynomial ... the brute-force way
xfine = 0:.001:1;
figure(1)
plot(x,y,'o',xfine,c(1)+c(2)*xfine+c(3)*xfine.^2+c(4)*xfine.^3+c(5)*xfine.^4+c(6)*xfine.^5)
axis([0 1 -2 2])

% use Matlab's built-ins to get the coefficients and plot the polynomial
p = polyfit(x,y',5)
figure(2)
plot(x,y,'o',xfine,polyval(p,xfine))
% plot(x,y,'o',xfine,polyval(flipud(c),xfine))

% do a least-squares fit:  quadratic polynomial to fit five data points
x = [1 2 3 5 7];
y = [2 3 0 -1 1]';
A = fliplr(vander(x));
A = A(:,1:3)                 % 5 x 3  matrix
c = A \ y

% plot the polynomial
xfine = 0:.01:8;
figure(3)
plot(x,y,'o',xfine,c(1)+c(2)*xfine+c(3)*xfine.^2)

% compare methods for least-squares fitting
cnew = (A'*A) \ (A'*y)          % solve the normal equations
%norm(c-cnew)
cthird = polyfit(x,y',2)        % use the built-in
%norm(c-flipud(cthird'))

% illustrate that the conditioning of A is better than that of A'*A
cond(A)
cond(A'*A)
sqrt(ans)

