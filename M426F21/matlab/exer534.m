% EXER534  Do Exercise 5.3.4 from Driscoll & Braun, parts (a) and (b).

n = [10 20 40 80 160];
for part = ['a','b']
    if part == 'a'
        f = @(x) cos(pi^2*x.^2);
        t0 = 0;  tn = 1;  scale = 10000;
    else
        f = @(x) log(x);
        t0 = 1;  tn = 3;  scale = 10;
    end
    xx = linspace(t0,tn,1600);  yy = f(xx);
    for k=1:5
        t = linspace(t0,tn,n(k));
        err(k) = norm(yy - interp1(t,f(t),xx,'spline'),'inf');
    end
    figure,  loglog(n,err,'o:',n,scale*n.^(-4),'--')
    axis tight,  xlabel n,  ylabel('||f-p||_{\infty}')
    title(['part ' part]),  legend('error','4th order')
end
