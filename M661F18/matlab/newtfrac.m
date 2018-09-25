function newtfrac(N)
% NEWTFRAC  Generate convergence fractal for Newton's method on exercise
% 7.10 on page 75 of Griva et al (2009)

if nargin < 1
    N = 50;  % default to coarse
end
xybox = [-1 1 -1 1];
Nnewt = 100; % maximum number of Newton steps to take

% problem
F = @(x) [x(1)^2+x(2)^2-1; 5*x(1)^2-x(2)-2];
JF = @(x) [2*x(1),  2*x(2);
           10*x(1), -1    ];
targets = {[0.473069769149142;   -0.881024967590677],
           [0.732260195;         0.681024968],
           [-0.473069769149142;  -0.881024967590677],
           [-0.732260195;        0.681024968]};

% generate grid of points in plane
x = linspace(xybox(1),xybox(2),N);
y = linspace(xybox(3),xybox(4),N);
[xx,yy] = meshgrid(x,y);

% go through grid and mark which root we are close to (if any)
c = zeros(N,N);
for mx = 1:length(x)
    for my = 1:length(y)
        z = [xx(mx,my); yy(mx,my)];
        for k = 1:Nnewt
            z = z - JF(z) \ F(z);
            p = testtargets(z);
            if p > 0   % we have decided on which root
                c(mx,my) = p;
                break
            end
        end
    end
end

% image colored by which root (as listed in targets)
jetw = jet;
jetw(1,:) = [1 1 1];  % make 0 color be white
imagesc(x,y,c,[0,max(max(c))])
colormap(jetw)
set(gca,'ydir','normal')
hold on
for p = 1:length(targets)
    r = targets{p};
    plot(r(1),r(2),'k.','MarkerSize',30)
end
hold off
title('black dots show roots')

    function q = testtargets(z)
        for p = 1:length(targets)
            if abs(z - targets{p}) < 1.0e-4
                q = p;
                return
            end
        end
        q = 0;
        return
    end

end  % newtfrac

