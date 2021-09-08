% POLYPLAY  Script to show use of built-in polynomial-related
% commands ROOTS, POLYVAL, and POLYFIT.

% 1. find the roots of p(x) = x^5 - 2 x^4 - 7x^3 + 20 x^2 - 12 x
% implementation: the book hints at how ROOTS is implemented in
%                 Chapter 7 (it is *not* obvious)
c = [1 -2 -7 20 -12 0];
roots(c)

% 2. plot p(x) and its roots on the same graph
% implementation: the book explains in section 1.3 that POLYVAL
%                 is just Horner's method (you could write it
%                 yourself)
figure(1)          % create a new figure
x = -3.5:.01:3;    % a convenient interval to see features
plot(x,polyval(c,x))
hold on
plot(roots(c),zeros(1,5),'ro')  % red circles
% same: plot(roots(c),[0 0 0 0 0],'ro')
xlabel('x')
ylabel('values')
grid on
hold off

% 3. find and plot the polynomial q(x) which goes through
% the points  (-2,4), (0,1), (1,2), (pi,0), (4,1)
% implementation: the book explains in section 2.1 that POLYFIT
%                 actually sets-up and solves a linear system
%                 (and we will discuss how to solve linear
%                 systems in Chapters 2 and 3)
figure(2)
xx = [-2 0 1 pi 4];
yy = [4 1 2 0 1];
plot(xx,yy,'r+')        % plot the points as red +
c2 = polyfit(xx,yy,4);  % coefficients of degree 4 polynomial
x2 = -2:.01:4;          % x2 is only used for plotting
hold on
plot(x2,polyval(c2,x2))
hold off
grid on