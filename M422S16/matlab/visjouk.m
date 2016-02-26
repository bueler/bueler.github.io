function visjouk(b,s,lambda)
% VISJOUK  Apply the Joukowsky [Khukovsky] transformation
%    f(z) = z + lambda^2/z
% to a circle with center FIXME

h = figure(1)
% draw axes in sub-figures
for k = 1:2
    subplot(1,2,k)
    plot([-5 5],[0 0],'k','linewidth',1.0), hold on
    plot([0 0],[-5 5],'k','linewidth',1.0)
    axis equal
end

% parameterize circle
theta = linspace(0,2*pi,201);
x = r*cos(theta)+a;
y = r*sin(theta)+b;

% draw circle in z-plane
subplot(1,2,1)
text(-4,4,'z-plane')
plot(x,y,'k','linewidth',2.0)
hold off

% draw image in w-plane
denom = x.^2 + y.^2;
u = x .* (lambda.^2 + denom) ./ denom;
v = - y .* (lambda.^2 - denom) ./ denom;

subplot(1,2,2)
text(4,4,'w-plane')
plot(u,v,'k','linewidth',2.0)
hold off

