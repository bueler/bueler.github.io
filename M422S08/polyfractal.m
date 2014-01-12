% POLYFRACTAL  Plot fractal associated to finding 
% roots in complex plane for a polynomial by using 
% Newton's method.

% USER-CONTROLLED PARAMETERS:

p = [3 0 1 0 13 4]   % coeffs of poly; polyfractal could be turned into
                     %   a function which takes p as input

Nxy = 200;           % number of points to use in each coordinate direction;
                     %   900 gives finer picture but takes longer
                     
viewxy = [-1.5 1.5 -1.5 1.5]; % region of complex plane to view

% METHOD PARAMETERS:

Nnewt = 100;         % maximum number of Newton steps to take; try "4" for
                     %   blobs of color w/o fractal boundaries
crit = 1.0e-3;       % how close one needs to get to decide which
                     %   root is being approximated; does not need to be
                     %   really small

% METHOD:

deg = length(p) - 1; % degree of polynomial
dp = (deg:-1:1) .* p(1:deg);  % exercise: what is this?
r = roots(p);        % we need to know the roots to determine
                     %   where Newton's method sent us
     
% generate grid of points in plane
x=linspace(viewxy(1),viewxy(2),Nxy+1); 
y=linspace(viewxy(3),viewxy(4),Nxy+1); 
[xx,yy]=meshgrid(x,y);

c = zeros(size(xx));  % points which don't converge will show white
for j=1:length(x)
  for k=1:length(y)
    z = xx(j,k) + i*yy(j,k);
    flags = (abs(z - r) < crit);  % same size as r
    count = 0;
    while (~any(flags)) & (count < Nnewt)
      z = z - polyval(p,z)./polyval(dp,z);
      count = count + 1;
      flags = (abs(z - r) < crit);
    end
    if count < Nnewt
      c(j,k) = 1+find(flags);
    end
  end
end

jetw = jet; jetw(1,:)=[1 1 1];  % make 0 color be white
imagesc(x,y,c,[0 deg+1]), colormap(jetw), hold on
plot3(real(r),imag(r),(deg+1)*ones(size(r)),'k.','MarkerSize',20)
hold off, axis square, axis tight
title('black dots show roots')
