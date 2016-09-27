function pitsslides(doprint)
% PITSSLIDES Generate figures for slide sequence on behavior of
%   steepest descent
%   Newton's method
% with backtracking line search.

if nargin < 1
    doprint = false;
end

x = -2.0:0.04:2.0;
y = -1.0:0.04:1.0;
[xx,yy] = meshgrid(x,y);

zz = zeros(size(xx));
for j = 1:size(xx,1)
    for k = 1:size(xx,2)
        zz(j,k) = pits([xx(j,k) yy(j,k)]);
    end
end


% four slides to show pits function and locus of  grad f = 0

figure(1), clf()
surf(x,y,zz)
shading('interp')
xlabel('x_1')
ylabel('x_2')
figprint('pits-surf')

figure(2), clf()
basecontour(x,y,zz)
figprint('pits-contour')

figure(3), clf()
basecontour(x,y,zz)
hold on
plot(x,-0.05 * x,'b',x,-8.0*x.^3+8.0*x-0.5,'b')
hold off
axis([-2 2 -1 1])
axis equal
figprint('pits-contour-curves')

figure(4), clf()
basecontour(x,y,zz)
axis([-2 2 -4 4])
hold on
plot(x,-0.05 * x,'b',x,-8.0*x.^3+8.0*x-0.5,'b')
hold off
figprint('pits-contour-curves-backout')


% three slides each to show behavior of sd and newton with back-tracking

tag = {'sd','newton'};

for method = 1:2
    x0list = [1.5 -0.2 -0.8;
              0.5 -1.0 -0.4];

    figure(5+(method-1)*3), clf()
    basecontour(x,y,zz)
    hold on
    for j = 1:3
	    x0 = x0list(:,j);
	    if method == 1
    	    [xk, xklist] = sdbtfixed(x0,4,@pits);
    	else
	        [xk, xklist, fxklist, notdesc] = newtonbtfixed(x0,4,@pits);
    	end
	    plot(xklist(1,:),xklist(2,:),'bo-')
        if ((method == 2) & any(notdesc))
            plot(xklist(1,notdesc),xklist(2,notdesc),'ro')
        end
	    plot(x0(1),x0(2),'ko','markersize',8)
	    plot(x0(1),x0(2),'ko','markersize',6)
    end
    hold off
    figprint(['pits-' tag{method}])

    figure(6+(method-1)*3), clf()
    szz = zeros(size(xx));
    for j = 1:size(xx,1)
	    for k = 1:size(xx,2)
	        szz(j,k) = scalepits([xx(j,k) yy(j,k)]);
	    end
    end
    contour(x,y,szz,[-2.5 -2.0 -1.0 0.0 1.0 4.0 8.0 13.0 20.0],'k')
    hold on
    xr = [-1.03284 0.97049 0.06235];
    yr = -0.05 * xr / 4.0;   % see "scale = 4.0" in scalepits.m
    plot(xr,yr,'gx','markersize',10)
    hold off
    xlabel('x_1')
    ylabel('x_2')
    hold on
    for j = 1:3
	    x0 = x0list(:,j);
	    if method == 1
    	    [xk, xklist] = sdbtfixed(x0,4,@scalepits);
    	else
	        [xk, xklist, fxklist, notdesc] = newtonbtfixed(x0,4,@scalepits);
    	end
	    plot(xklist(1,:),xklist(2,:),'bo-')
        if ((method == 2) & any(notdesc))
            plot(xklist(1,notdesc),xklist(2,notdesc),'ro')
        end
	    plot(x0(1),x0(2),'ko','markersize',8)
	    plot(x0(1),x0(2),'ko','markersize',6)
    end
    hold off
    axis equal
    figprint(['pits-' tag{method} '-scaley'])

    figure(7+(method-1)*3), clf()
    basecontour(x,y,zz)
    hold on
    for j = 1:3
	    x0 = x0list(:,j);
	    if method == 1
    	    [xk, xklist] = sdbtfixed(x0,4,@fscalepits);
    	else
	        [xk, xklist, fxklist, notdesc] = newtonbtfixed(x0,4,@fscalepits);
    	end
	    plot(xklist(1,:),xklist(2,:),'bo-')
        if ((method == 2) & any(notdesc))
            plot(xklist(1,notdesc),xklist(2,notdesc),'ro')
        end
	    plot(x0(1),x0(2),'ko','markersize',8)
	    plot(x0(1),x0(2),'ko','markersize',6)
    end
    hold off
    figprint(['pits-' tag{method} '-scalef'])
end

    function basecontour(x,y,zz)
    contour(x,y,zz,[-2.5 -2.0 -1.0 0.0 1.0 4.0 8.0 13.0 20.0],'k')
    hold on
    xr = [-1.03284 0.97049 0.06235];
    yr = -0.05 * xr;
    plot(xr,yr,'gx','markersize',10)
    hold off
    xlabel('x_1')
    ylabel('x_2')
    axis equal
    end

	function figprint(name)
		if doprint
		    print([name '.png'],'-dpng','-tight')
		    %%  since '-tight' doesn't really work in octave:
		    %  for NAME in *.png; do mogrify -trim $NAME; done
		end
	end

end

