% P20CD part of solution to P20

% set up functions
rr = @(x) [x(1)^2 + x(2)^2 - 1;  0.5 * exp(2 * x(1)) - x(2)];
JJ = @(x) [2 * x(1),  2 * x(2);  exp(2 * x(1)),  -1];
ff = @(x) 0.5 * rr(x)' * rr(x);        % merit function

% first iterate
x0 = [1; 1];
p0 = JJ(x0) \ (-rr(x0))
phi = @(alpha) ff(x0 + alpha * p0);    % line search function

% plot phi(alpha)
alf = 0:.01:7;  y = zeros(size(alf));
for k = 1:length(alf)
   y(k) = phi(alf(k));
end
plot(alf,y,'k','linewidth',6),  hold on
plot(1.0,phi(1.0),'k.','markersize',24)   % mark full step alpha = 1
grid on,  xlabel('alpha'),  ylabel('phi(alpha)')

% add Wolfe condition lines to graph, and report
cA = 1.0e-4;   cB = 0.25;              % constants in Wolfe A,B
m0 = rr(x0)' * JJ(x0) * p0;            % slope phi'(0)
fA = ff(x0) + cA * m0 * 1.0;
if phi(1.0) <= fA
    fprintf('Wolfe A goal SATISFIED:  %.6f <= %.6f\n',phi(1.0),fA)
else
    fprintf('Wolfe A goal NOT SATISFIED:  %.6f > %.6f\n',phi(1.0),fA)
end
plot(alf,ff(x0) + cA * m0 * alf,'k--','linewidth',3)
x1 = x0 + 1.0 * p0;
m1 = rr(x1)' * JJ(x1) * p0;            % slope phi'(1)
if m1 >= cB * m0
    fprintf('Wolfe B goal SATISFIED:  %.6f >= %.6f\n',m1,cB * m0)
else
    fprintf('Wolfe B goal NOT SATISFIED:  %.6f < %.6f\n',m1,cB * m0)
end
plot(alf,phi(1.0) + cB * m0 * (alf - 1),'k:','linewidth',3)
axis([0 7 -1 5]),  hold off

