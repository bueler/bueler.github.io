function drum(N)
% DRUM  Two views of the eigenmodes of a circular vibrating drumhead.  This 
% function is nothing but a wrapper for program 28 (p28.m) and cheb.m in 
% L. N. Trefethen, "Spectral Methods in MATLAB", SIAM Press 2000.
% Example:  >> drum
% (One can also specify number of radial Chebyshev pts N; see code first.)
% ELB 11/29/05

if nargin==0
    N=25; M=20;
elseif nargin==1
    if floor(N/2)==N/2, error('N must be odd'), end
    if N<7, error('N must be at least 7'), end
    M=2*ceil(0.4*N);  % M is even and M/N is at least .8
end

% p28.m - eigenmodes of Laplacian on the disk (compare p22.m)
% r coordinate, ranging from -1 to 1 (N must be odd):
  % N = 25; 
  N2 = (N-1)/2;
  [D,r] = chebHERE(N);
  D2 = D^2;
  D1 = D2(2:N2+1,2:N2+1); D2 = D2(2:N2+1,N:-1:N2+2);
  E1 =  D(2:N2+1,2:N2+1); E2 =  D(2:N2+1,N:-1:N2+2);
% t = theta coordinate, ranging from 0 to 2*pi (M must be even):
  % M = 20; 
  dt = 2*pi/M; t = dt*(1:M)'; M2 = M/2;
  D2t = toeplitz([-pi^2/(3*dt^2)-1/6 ...
                 .5*(-1).^(2:M)./sin(dt*(1:M-1)/2).^2]);
% Laplacian in polar coordinates:
  R = diag(1./r(2:N2+1));
  Z = zeros(M2); I = eye(M2);
  L = kron(D1+R*E1,eye(M)) + kron(D2+R*E2,[Z I;I Z]) ...
                           + kron(R^2,D2t);       
% Compute four eigenmodes:
  index = [1 3 6 10];
  [V,Lam] = eig(-L); Lam = diag(Lam); [Lam,ii] = sort(Lam);
  ii = ii(index); V = V(:,ii);
  Lam = sqrt(Lam(index)/Lam(1));
% Plot eigenmodes with nodal lines underneath:
figure(1)
  [rr,tt] = meshgrid(r(1:N2+1),[0;t]);
  [xx,yy] = pol2cart(tt,rr);
  z = exp(1i*pi*(-100:100)/100);
  [ay,ax] = meshgrid([.58 .1],[.1 .5]); clf
  for i = 1:4
    u = reshape(real(V(:,i)),M,N2);
    u = [zeros(M+1,1) u([M 1:M],:)];
    u = u/norm(u(:),inf);
    subplot('position',[ax(i) ay(i) .4 .4])
    plot(z), axis(1.05*[-1 1 -1 1 -1 1]), axis off, hold on
    mesh(xx,yy,u)
    view(0,20), colormap(1e-6*[1 1 1]); axis square
    contour3(xx,yy,u-1,[-1 -1])
    plot3(real(z),imag(z),-abs(z))
    text(-.8,4,['Mode ' int2str(index(i))],'fontsize',9)
    text(-.8,3.5, ['\lambda = ', num2str(Lam(i),...
                               '%16.10f')],'fontsize',9)
  end

% plot produced by p28b.m:
figure(2)
% Compute 25 eigenmodes:
  index = 1:25;
  [V,Lam] = eig(-L); Lam = diag(Lam);
  [Lam,ii] = sort(real(Lam)); ii = ii(index); V = real(V(:,ii));
  Lam = sqrt(Lam(index)/Lam(1));
% Plot eigenmodes with nodal lines underneath:
  [rr,tt] = meshgrid(r(1:N2+1),[0;t]); %[xx,yy] = pol2cart(tt,rr);
  z = exp(sqrt(-1)*pi*(-100:100)/100);
  [ay,ax] = meshgrid(.8:-.2:0,0:.16:.64); clf
  for i = 1:25
    u = reshape(real(V(:,i)),M,N2);
    u = [zeros(M+1,1) u([M 1:M],:)];
    u = u/norm(u(:),inf);
    subplot('position',[ax(i) ay(i) .16 .2]), plot(z)
    axis(1.25*[-1 1 -1 1 -1 1]), axis off, hold on
    view(0,90), colormap(1e-6*[1 1 1]); axis square
    contour3(xx,yy,u-1,[-1 -1]), plot3(real(z),imag(z),-abs(z))
    text(-.3,1.15,num2str(Lam(i)),'fontsize',7)
  end

  
% CHEB  compute D = differentiation matrix, x = Chebyshev grid
  function [D,x] = chebHERE(N)
  if N==0, D=0; x=1; return, end
  x = cos(pi*(0:N)/N)'; 
  c = [2; ones(N-1,1); 2].*(-1).^(0:N)';
  X = repmat(x,1,N+1);
  dX = X-X';                  
  D  = (c*(1./c)')./(dX+(eye(N+1)));      % off-diagonal entries
  D  = D - diag(sum(D'));                 % diagonal entries

