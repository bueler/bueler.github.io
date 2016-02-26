function visjouk(b,s,t)
% VISJOUK  Apply the Joukowsky [Khukovsky] transformation
%     f(z) = z + lambda^2/z
% to a circle with radius b and center (s,t).  We compute
%     lambda = b - |s|
% Examples which generate airfoil shapes:
%   >> visjouk(1.0,0.1,0.0)         % symmetric
%   >> visjouk(1.0,0.1,0.1)         % with camber
%   >> visjouk(1.130,-0.100,0.06)   % close to NACA 4412 airfoil (Kapania et al 2008)

lambda = b - abs(s);

L = 2.5 * b;

h = figure(1)
% draw axes in sub-figures
for k = 1:2
    subplot(1,2,k)
    plot([-L L],[0 0],'k','linewidth',1.0), hold on
    plot([0 0],[-L L],'k','linewidth',1.0)
    axis equal
    axis tight
end

% parameterize circle
theta = linspace(0,2*pi,201);
x = b*cos(theta)+s;
y = b*sin(theta)+t;

% draw circle in z-plane
subplot(1,2,1)
text(-4,4,'z-plane')
plot(x,y,'k','linewidth',2.0)
plot(s,t,'k.','markersize',8)
hold off

% draw image in w-plane
denom = x.^2 + y.^2;
u = x .* (denom + lambda.^2) ./ denom;
v = y .* (denom - lambda.^2) ./ denom;

subplot(1,2,2)
text(4,4,'w-plane')
plot(u,v,'k','linewidth',2.0)
hold off

