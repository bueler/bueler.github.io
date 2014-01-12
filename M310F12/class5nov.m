% CLASS5NOV  demonstration of POLYFIT, POLYVAL, and A\b
% black boxes for solving least squares fitting problems

% enter the points as vectors
x = [0 1 2 4 6];
y = [2 1 3 0 1];

% nice to show the points
plot(x,y,'o','markersize',14)  % blue points; blue is default
axis([-1 7 -1 4]),  grid on,  hold on

% use POLYFIT to get exact 4th degree poly
pex = polyfit(x,y,4);

% plot that
xfine = -1:.01:7;
yex = polyval(pex,xfine);
plot(xfine,yex,'r')  % red curve

% use POLYFIT to get 2nd degree poly that fits data in least squares sense
pquad = polyfit(x,y,2);

% plot that
yquad = polyval(pquad,xfine);
plot(xfine,yquad,'g')  % green curve

% also show degree 3 that fits in least squares sense
pcub = polyfit(x,y,3);
ycub = polyval(pcub,xfine);
plot(xfine,ycub,'m')  % magenta curve

% finally, regenerate  pquad  by hand by building 5x3 matrix  A  and
%   the overdetermined system  A x = b  where x is the coefficients
%   of the 2nd degree polynomial
A = [ones(5,1) x' (x.^2)']
b = y'
x = A \ b

% compare the coefficients we got earlier
pquad

