% CLASS17OCT  Brief demo of
%    piecewise-linear interpolation
%    piecewise cubic Hermite interpolation [Matlab's version]
%    spline interpolation
% on randomly-generated "data".

x = 0:4;
y = rand(1,5);
xx = 0:.01:4;
pp = pchip(x,y);         % one does not need to even
pps = spline(x,y);       %     look at these data structures!
plot(x,y,'o',x,y,xx,ppval(pp,xx),xx,ppval(pps,xx))
xlabel x
legend('data','piecewise-linear','pchip','spline')

