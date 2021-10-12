% TWOFITS  Fit the curve  f(t) = exp(sin(t-1))  in two different ways,
% first using a polynomial of degree 7 and then using a combination of
% low-frequency sinusoids.  See Exercise 3.1.3 in Driscoll & Braun.

% we will fit at 200 equally-spaced points in [0, 2 pi]
t = linspace(0, 2*pi, 200)';
b = exp(sin(t - 1));             % exp() and sin() evaluate entry-wise

% (a) fit  p(t) = c(1) + c(2) t + ... + c(8) t^7  via built-in polyfit
c = polyfit(t, b, 7)

% (b) fit  q(t) = d(1) + d(2) cos(t) + ... + d(5) sin(2 t)
A = [ones(size(t)), cos(t), sin(t), cos(2*t), sin(2*t)];
d = A \ b;
d'

% (c) plot using a finer grid
tt = linspace(0,2*pi,2000)';
% compute the values of q(t) from part (b):
qq = d(1) + d(2)*cos(tt) + d(3)*sin(tt) + d(4)*cos(2*tt) ...
     + d(5)*sin(2*tt);
plot(t, b, 'r.', ...                  % plot the data as markers
     tt, polyval(c, tt), 'b', ...     % plot  p(t)
     tt, qq, 'g')                     % plot  q(t)
legend('f(t) = exp(sin(t-1))', ...
       'p(t) is 7th-degree polynomial fit', ...
       'q(t) is 5-parameter trigonometric fit')
xlabel t,  axis tight
