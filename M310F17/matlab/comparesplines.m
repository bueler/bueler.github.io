% COMPARESPLINES  Compare four different ways of drawing a curve through data.

x = 0.0:0.5:3.5;
y = sin(x.^2);

xx = 0:.01:3.5;
for q = 1:4
    subplot(4,1,q)
    switch q
        case 1
            n = length(x) - 1;
            plot(xx,polyval(polyfit(x,y,n),xx),'k')
            title('polynomial')
        case 2
            p1 = interp1(x, y, xx);
            plot(xx,p1,'k')
            title('piecewise-linear')
        case 3
            [a, b, c] = quadspline(x,y);
            plotqs(x,y,a,b,c)
            title('quadratic spline')
        case 4
            plot(xx,ppval(spline(x,y),xx),'k')
            title('cubic spline')
        otherwise
            error('invalid case')
    end % switch
    % show the data as markers and f(x) as dashed
    hold on, plot(x,y,'ko',xx,sin(xx.^2),'k--'), hold off
    xlabel x
end % for
