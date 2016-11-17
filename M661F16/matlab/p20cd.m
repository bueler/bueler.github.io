% P20CD part of solution to P20

% set up functions
JJ = @(x) [2 * x(1),  2 * x(2);  exp(2 * x(1)),  -1];
rr = @(x) [x(1)^2 + x(2)^2 - 1;  0.5 * exp(2 * x(1)) - x(2)];
ff = @(x) 0.5 * rr(x)' * rr(x);       % merit function

% find p for first iterate
x0 = [1; 1];
p0 = JJ(x0) \ (-rr(x0))

% line search function at x0 in direction p0
phi = @(alpha) ff(x0 + alpha * p0);

% plot phi(alpha)
alf = 0:.01:7;
y = zeros(size(alf));
for k = 1:length(alf)
   y(k) = phi(alf(k));
end
plot(alf,y,'linewidth',2),  hold on
plot(1.0,phi(1.0),'ro','markersize',14),  hold off
grid on,  xlabel('alpha'),  ylabel('phi(alpha)')

% add Wolfe condition lines to graph
%FIXME

