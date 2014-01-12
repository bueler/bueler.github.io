% INCLASS21OCT   Shows how Ed used Newton's method to find the intersections of
% the graph  y = e^x  and the circle of radius 5 centered at the origin.

% plot the graph  y = f(x)  for which we are solving  f(x) = 0
x = -5:.01:5;  plot(x,exp(x) - sqrt(25 - x.^2))
axis([-5 5 -5 5])
grid on

% apply Newton's method to find right-hand intersection
format long
x = 1.5
x = x - (exp(x) - sqrt(25 - x^2)) / (exp(x) + x / sqrt(25 - x^2))
x = x - (exp(x) - sqrt(25 - x^2)) / (exp(x) + x / sqrt(25 - x^2))
x = x - (exp(x) - sqrt(25 - x^2)) / (exp(x) + x / sqrt(25 - x^2))
x = x - (exp(x) - sqrt(25 - x^2)) / (exp(x) + x / sqrt(25 - x^2))
x = x - (exp(x) - sqrt(25 - x^2)) / (exp(x) + x / sqrt(25 - x^2))
exp(x),  sqrt(25 - x^2)

% for the left-hand intersection, I had to try harder just to get
% a reasonable starting point; after experimentation I found that
% this starting point worked:
x = -4.99999
exp(x), sqrt(25 - x^2)   % the fact that these are both small suggests
                         % it will work
x = x - (exp(x) - sqrt(25 - x^2)) / (exp(x) + x / sqrt(25 - x^2))
x = x - (exp(x) - sqrt(25 - x^2)) / (exp(x) + x / sqrt(25 - x^2))
x = x - (exp(x) - sqrt(25 - x^2)) / (exp(x) + x / sqrt(25 - x^2))
x = x - (exp(x) - sqrt(25 - x^2)) / (exp(x) + x / sqrt(25 - x^2))
x = x - (exp(x) - sqrt(25 - x^2)) / (exp(x) + x / sqrt(25 - x^2))
x = x - (exp(x) - sqrt(25 - x^2)) / (exp(x) + x / sqrt(25 - x^2))

