% REGIONS  Plot stability regions for three second-order ODE IVP schemes
% This version uses imagesc instead of contour.

x = linspace(-5,5,300);  y = x;  [xx,yy] = meshgrid(x,y);
zz = xx + i*yy;
mycmap = colormap('gray');  mycmap = mycmap(64:-1:35,:);  % better grayscale
uu = ((abs(1 + zz/2) ./ abs(1 - zz/2)) <= 1);
subplot(1,3,1),  imagesc(x,y,uu),  colormap(mycmap)
grid on,  axis square,  title('TR')
uu = (abs(1 + zz + zz.^2/2) <= 1);
subplot(1,3,2),  imagesc(x,y,uu),  colormap(mycmap)
grid on,  axis square,  title('RK2')
uu = (abs((2+sqrt(1+2*zz)) ./ (3-2*zz)) <= 1) ...
     .* (abs((2-sqrt(1+2*zz)) ./ (3-2*zz)) <= 1);
subplot(1,3,3),  imagesc(x,y,uu),  colormap(mycmap)
grid on,  axis square,  title('BDF2')
