function newtonfractal(ex,Nxy,viewxy)
% NEWTONFRACTAL  Plot fractal associated to Newton's method in the complex plane
% Example 1 f(z)=z^4+z^2-1:
%   >> newtonfractal
%   >> newtonfractal(1)          % same: default is example 1
%   >> newtonfractal(1,60)       % same: default is 60x60 grid
% Higher resolution:
%   >> newtonfractal(1,200)
% Detail:
%   >> newtonfractal(1,200,[0 1 0 1])
% Yet higher resolution (slow) on second example f(z)=cos(z)-z^3:
%   >> newtonfractal(2,500)

if nargin < 3
    viewxy = [-2 2 -2 2]; % region of complex plane to view
end
if nargin < 2
    Nxy = 60;             % pixels in each direction; resolution
end
if nargin < 1
    ex = 1;               % which example problem
end

% DESCRIBE PROBLEM
if ex == 1
    f = @(z) z.^4 + z.^2 - 2;
    df = @(z) 4*z.^3 + 2*z;
    targets = [1, -1, sqrt(2)*i, -sqrt(2)*i];
else
    f = @(z) cos(z) - z.^3;
    df = @(z) -sin(z) - 3*z.^2;
    targets = [0.865474033101614,
               -0.676359355882742 - 0.82081280466839i,
               -0.676359355882742 + 0.82081280466839i];
end

% METHOD PARAMETER:
Nnewt = 100; % maximum number of Newton steps to take; "4" give blobs of
             % color w/o fractal boundaries

% generate grid of points in plane
x = linspace(viewxy(1),viewxy(2),Nxy);
y = linspace(viewxy(3),viewxy(4),Nxy);
[xx,yy] = meshgrid(x,y);

% go through grid and mark which root we are close to (if any)
c = zeros(Nxy,Nxy);
for mx = 1:length(x)
    for my = 1:length(y)
        z = xx(mx,my) + i*yy(mx,my);
        for k = 1:Nnewt
            znew = z - f(z) / df(z);
            p = testtargets(znew);
            if p > 0
                c(mx,my) = p;  % we have decided on which root
                break
            else
                z = znew;      % keep going
            end
        end
    end
end

% image colored by which root (as listed in targets)
jetw = jet; jetw(1,:) = [1 1 1];  % make 0 color be white
imagesc(x,y,c,[0,max(max(c))])
colormap(jetw)
set(gca,'ydir','normal')
hold on
for p = 1:length(targets)
    r = targets(p);
    plot(real(r),imag(r),'k.','MarkerSize',14)
end
hold off  % axis square, axis tight
title('black dots show roots')

    function q = testtargets(z)
        for p = 1:length(targets)
            if abs(z - targets(p)) < 1.0e-4
                q = p;
                return
            end
        end
        q = 0;
        return
    end  % testtargets

end  % newtonfractal

