function visfunction(g,xx,yy)
% VISFUNCTION  Visualize a function  w = g(z)  by applying it to a grid of
% points in the z-plane and showing the result in the w-plane.
% Examples:
%   >> visfunction(@(z) z.^2,0:0.1:1,-1:.2:1)

% FIXME allow one, two, or three arguments

subplot(1,2,1)
plot([min(xx) max(xx) max(xx) min(xx) min(xx)],
     [min(yy) min(yy) max(yy) max(yy) min(yy)], 'k','linewidth',4.0)
hold on
plot([-3 3],[0 0],'k')
plot([0 0],[-3 3],'k')
for j = 2:length(xx)-1
    plot([xx(j) xx(j)],[min(yy) max(yy)],'b','linewidth',1.0)
end
for j = 2:length(yy)-1
    plot([min(xx) max(xx)],[yy(j) yy(j)],'r','linewidth',1.0)
end
axis off
hold off

subplot(1,2,2)
xshift = 5.0;
for j = 1:length(xx)
    for k = 1:length(yy)
        w = g(xx(j) + i*yy(k));
        plot(real(w)+xshift,imag(w),'ko')
        hold on
    end
end
axis off
hold off
