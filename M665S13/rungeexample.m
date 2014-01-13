% RUNGEEXAMPLE  After the end of class on Friday 1/25 I talked about
% a famous polynomial interpolation example.
%
% Extra Credit:  Put a loop around this and show a movie demonstrating
% the non-convergence of the equally-spaced case and the convergence
% of the Chebyshev case, as the number of points increases.

f = @(x) 1./(1+x.^2);          % this is called the "Runge function"

% compute p(x) which fits f(x) at equally-spaced points:
x = -5:1:5;                    % 11 equally-spaced points
y = f(x);                      % we want to fit the data (x,f(x)) = (x,y)
c = polyfit(x,y,10);           % c = coeffs of degree 10 poly through data

% plot points and p(x) and f(x)
figure(1), clf
plot(x,y,'bo','markersize',10) % data as blue circles
hold on
xx = -6:.01:6;                 % lots of points for smooth plot
plot(xx,polyval(c,xx),'b')     % smooth plot of p(x)
plot(xx,f(xx),'k','linewidth',2.0) % smooth plot of f(x)

% compute and plot p_cheb(x) which fits f(x) at 11 "Chebyshev" points
xcheb = 5 * cos((0:10)*pi/10); % the Cheb. points
plot(xcheb,f(xcheb),'r*','markersize',9)
ccheb = polyfit(xcheb,f(xcheb),10); % coefficients of p_cheb(x)
plot(xx,polyval(ccheb,xx),'r')

% finalize plot
axis([-6 6 -1.5 2.5])
grid on
xlabel('x')
title('equal-spaced p(x) [blue] versus Chebyshev p_{cheb}(x) [red]')
hold off
