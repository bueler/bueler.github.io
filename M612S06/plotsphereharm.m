function plotsphereharm(l,m,N)
% PLOTSPHEREHARM Plot spherical harmonics.
%
%    PLOTSPHEREHARM(L,M) shows three views of Y_l^m(theta,phi)
%
% ELB 4/27/06

if nargin<3, N=200; end

phi = 2*pi*(0:N)/N;
theta = pi*(0:N)'/N;
X = sin(theta)*cos(phi);
Y = sin(theta)*sin(phi);
Z = cos(theta)*ones(size(phi));

rY=zeros(size(Z));  iY=rY;
for j=1:N+1
    z=Ylm(l,m,theta',phi(j));
    rY(:,j)=real(z)';  iY(:,j)=imag(z)';
end

subplot(4,2,1:6)
H=surf(X,Y,Z,rY);
set(H,'EdgeColor','none'); axis square, shading interp
title(['Re Y_{' num2str(l) '}^{' num2str(m) '}(\theta,\phi)'])
colorbar('SouthOutside')
subplot(4,2,7)
H=surf(X,Y,Z,iY);
set(H,'EdgeColor','none'); axis square, shading interp
title(['Im Y_{' num2str(l) '}^{' num2str(m) '}(\theta,\phi)'])
colorbar('EastOutside')
subplot(4,2,8)
H=surf(X,Y,Z,sqrt(rY.^2+iY.^2));
set(H,'EdgeColor','none'); axis square, shading interp
title(['abs Y_{' num2str(l) '}^{' num2str(m) '}(\theta,\phi)'])
colorbar('EastOutside')

function z=Ylm(l,m,theta,phi)
% vectorized over theta, a row vector, only
if m>=0
    PPN=legendre(l,cos(theta),'norm');
    PN=PPN(m+1,:);
    z=(-1)^m*exp(i*m*phi)*PN/sqrt(2*pi);
else
    z=(-1)^abs(m)*Ylm(l,abs(m),theta,phi);
end