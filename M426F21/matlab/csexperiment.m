% CSEXPERIMENT  Plot and compare accuracy of piecewise-linear (PL) and
% cubic spline (CS) interpolation of  f(x) = sin(5x)  on [0,3].

nn = [10 20 40 80 160 320];
plerr = zeros(size(nn));
cserr = plerr;
for q = 1:length(nn)
    n = nn(q);
    t = linspace(0,3,n+1);     % nodes
    y = sin(5*t);              % points are (t(k),y(k))
    xx = linspace(0,3,1001);   % used to plot and measure
    yy = sin(5*xx);
    plerr(q) = norm(yy - interp1(t,y,xx), 'inf');
    cserr(q) = norm(yy - interp1(t,y,xx,'spline'), 'inf');
    if q == 1  % show lowest resolution interpolation result
        figure(1)
        plot(xx,yy,'g', xx,interp1(t,y,xx),'b', xx,interp1(t,y,xx,'spline'),'r')
        legend('f(x)=sin(5x)','PL interpolant p(x)','cubic spline S(x)',...
               'location','southwest')
        title('n=10 case')
        xlabel x,  ylabel y
        axis tight
    end
end
ppl = polyfit(log(nn),log(plerr),1);
pcs = polyfit(log(nn),log(cserr),1);
figure(2)
loglog(nn,plerr,'o:', nn,cserr,'*:')
legend(sprintf('PL error is O(n^{%.2f})',ppl(1)),...
       sprintf('CS error is O(n^{%.2f})',pcs(1)),...
       'location','southwest')
xlabel n,  ylabel('uniform error')
set(gca,'xtick',nn)
axis tight
