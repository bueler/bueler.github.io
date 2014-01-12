function bidisc(M,N)
% BIDISC  surface plot of solution  u(r,theta)  to Dirichlet problem for
% unit disc:
%    Laplacian u = 0,          0 <= r < 1, 0 <= theta < 2 pi
% with
%                            /  1,  upper semicircle
%    g(theta) = u(1,theta) = |
%                            \ -1,  lower semicircle.
% Examples:
%    >> bidisc          % note figure can be rotated
%    >> bidisc(100,10)  % shows low-frequency approx of square wave on circle
%    >> bidisc(200,200), shading flat  % nice figure

if nargin < 1, M = 40; end
if nargin < 2, N = 40; end

% set up polar coord grid for plotting
theta = linspace(0,2*pi,M);
r = linspace(0,1,M);
[rr,thth] = meshgrid(r,theta);
xx = rr .* cos(thth);
yy = rr .* sin(thth);

uu = zeros(size(rr));
for k = 0:N
  n = 2*k+1;
  uu = uu + (4/(n*pi)) * rr.^n .* sin(n*thth);
end
figure(1)
surf(xx,yy,uu)
xlabel x, ylabel y, zlabel u
title('u(r,theta)    [figure can be rotated]')

