% NEWTONFRACTAL  Produce a figure like Figure 4.16 in Greenbaum&Chartier, but
% using intersection of two curves in the plane:
%   x^3 - 3 x y^2 + 1 = 0
%   3 x^2 y - y^3     = 0
% (It is the same figure, but without using complex numbers.)

N = 101;

% define the functions
f1 = @(x,y) x.^3 - 3*x.*y.^2 + 1;
f2 = @(x,y) 3*x.^2.*y - y.^3;

% define the Jacobian (this is not the most efficient way)
df11 = @(x,y) 3*x.^2 - 3*y.^2;
df12 = @(x,y) - 6*x.*y;
df21 = @(x,y) 6*x.*y;
df22 = @(x,y) 3*x.^2 - 3*y.^2;

% the exact solutions are known:
xstar = [-1.0,0.5,0.5];
ystar = [0.0,sqrt(3)/2,-sqrt(3)/2];
colorstar = {'g.','r.','b.'};

% generate NxN grid
xrange = linspace(-2,2,N);
[xx,yy] = meshgrid(xrange,xrange);

% first figure shows the intersecting curves and the roots
figure(1),  clf()
contour(xx,yy,f1(xx,yy),'c',[0 0])
hold on
contour(xx,yy,f2(xx,yy),'m',[0 0])
plot(xstar(1),ystar(1),'g.','markersize',28)
plot(xstar(2),ystar(2),'r.','markersize',28)
plot(xstar(3),ystar(3),'b.','markersize',28)
hold off
axis equal
xlabel x,  ylabel y
title('RGB dots mark intersections of curves')

% go through the grid identifying which root is being converged to
% by the following scheme:   zz(k,l) is 0,1,2,3 if
%   0: root not identified
%   1: (-1,0)
%   2: (1/2,sqrt(3)/2)
%   3: (1/2,-sqrt(3)/2)
zz = zeros(size(xx));
for k = 1:size(xx,1)
    for l = 1:size(xx,2)
        x = xx(k,l);
        y = yy(k,l);
        for n = 1:30
            F = [f1(x,y); f2(x,y)];
            A = [df11(x,y), df12(x,y); df21(x,y), df22(x,y)];
            S = - A \ F;  % solve linear system
            x = x + S(1);
            y = y + S(2);
        end
        for m = 1:3
            if norm([x; y] - [xstar(m); ystar(m)]) < 0.1
                zz(k,l) = m;
            end
        end
    end
end

% second figure shows the fractal
figure(2),  clf()
surf(xx,yy,zz)
colormap([1 1 1; 0 1 0; 1 0 0; 0 0 1])  % [white,green,red,blue]
shading flat
view(2)
axis equal, axis off
xlabel x,  ylabel y
title('RGB colors show destination of the Newton iteration')

