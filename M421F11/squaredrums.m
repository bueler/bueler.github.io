function squaredrums(M,N)
% SQUAREDRUMS  Show an array of the first M by N eigenfunctions u(x,y)
% which solve
%    u_xx + u_yy + lambda^2 u = 0
% on the unit square 0<x<1, 0<y<1, with u=0 on the boundary of the
% square.  That is, we show solutions of the Helmholz-Dirichlet problem.
% Example:  >> squaredrums

if nargin<1, M=4; end
if nargin<2, N=4; end
figure(1)
[x,y] = meshgrid(0:.01:1,0:.01:1);  % 100 x 100 grid
for m=1:M
  for n=1:N
    u = sin(m*pi*x) .* sin(n*pi*y);
    subplot(M,N,m+N*(n-1))
    surf(x,y,u), shading flat, view(2), axis equal, axis tight
    if m+n <= 2
      xlabel x, ylabel y
    else
      axis off
    end
    title(sprintf('m=%d, n=%d',m,n))
    lambda = pi*sqrt(m^2+n^2);
    text(0.5,0.9,sprintf('%.5f',lambda))
  end
end
