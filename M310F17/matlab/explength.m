% EXPLENGTH  Computes and plots the arclength of y=e^x,
%            /x
%     E(x) = | sqrt(1 + (e^x)^2) dx,
%            /0
% using Simpson's rule.  Plots y=E(x) on [0,3].

f = @(x) sqrt(1+exp(2*x));
h = 0.01;
x = 0:2*h:3;          % x-values; 151 points for plotting
E = zeros(size(x));   % allocates space for y-values; sets E(1)
for j = 2:length(x)
    c = (x(j-1) + x(j)) / 2;     % midpoint of [x_j-1,x_j]
    E(j) = E(j-1) + (h/3) * (f(x(j-1)) + 4 * f(c) + f(x(j)));
end
plot(x,E,'k'),  grid on,  xlabel x,  ylabel('E(x)')

