function vistaylor(x0,N)
% VISTAYLOR  Visualize 0th, 1st, and 2nd order Taylor approximations
% to a function of two variables.  (Visualization in 3D requires effort!)

% set defaults
if nargin < 1
    x0 = [0.2; 2];
end
if nargin < 2
    N = 41;
end

% function, gradient, Hessian  (vectorized)
f = @(x,y) exp(-x.^2) .* sin(y);
gradf = @(x,y) [-2.0 * x .* sin(y) .* exp(-x.^2);
                cos(y) .* exp(-x.^2)];
Hessf = @(x,y) [(-2.0 + 4.0 * x.^2) .* sin(y) .* exp(-x.^2),...
                       -2.0 * x .* cos(y) .* exp(-x.^2);
                -2.0 * x .* cos(y) .* exp(-x.^2),...
                       -sin(y) .* exp(-x.^2)];

% generate grid
x = linspace(-4,4,N);  y = x;
[xx,yy] = meshgrid(x,y);    % xx, yy are NxN arrays

% derivatives at x0
f0 = f(x0(1),x0(2));
v0 = gradf(x0(1),x0(2));
M0 = Hessf(x0(1),x0(2));

% Taylor approximations
T0 = f0 * ones(size(xx));
T1 = T0 + v0(1) * (xx - x0(1)) + v0(2) * (yy - x0(2));
T2 = T1 + 0.5 * (M0(1,1) * (xx - x0(1)).^2 + ...
                 2 * M0(1,2) * (xx - x0(1)) .* (yy - x0(2)) + ...
                 M0(2,2) * (yy - x0(2)).^2);

% plots with Taylor approxs
TT = {T0,T1,T2};   % put in cell array; convenient for following loop
for k = 0:2
    figure(k+1)
    % black wire mesh for  z = f(x,y)
    h = mesh(x,y,f(xx,yy));
    set(h,'edgecolor','k')
    hold on
    % colored surface for  z = Tk(x,y)
    surf(x,y,TT{k+1})
    drawdot(x0(1),x0(2),f0)
    hold off
    xlabel x, ylabel y
    axis equal
end

function drawdot(x,y,z)
    r = 0.07;
    [th,phi] = meshgrid(0:pi/4:2*pi,0:pi/8:pi);
    dh = surf(x+r*sin(phi).*cos(th), y+r*sin(phi).*sin(th), z+r*cos(phi));
    set(dh,'facecolor','k')

