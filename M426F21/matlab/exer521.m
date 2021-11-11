% EXER521  Do Exercise 5.2.1 from Driscoll & Braun, parts (a) and (b).

n = [10 20 40 80 160];
f = @(x) cos(pi^2*x.^2);   % part (a)
xx = linspace(0,1,1600);  yy = f(xx);
for k=1:5
    t = linspace(0,1,n(k));
    err(k) = norm(yy - interp1(t,f(t),xx),'inf');
end
figure(1),  loglog(n,err,'o:',n,100*n.^(-2),'--')
axis tight,  xlabel n,  ylabel('||f-p||_{\infty}')
legend('error','2nd order')

% f(x) = log(x)            % part (b)
xx = linspace(1,3,1600);  yy = log(xx);
for k=1:5
    t = linspace(1,3,n(k));
    err(k) = norm(yy - interp1(t,log(t),xx),'inf');
end
figure(2),  loglog(n,err,'o:',n,n.^(-2),'--')
axis tight,  xlabel n,  ylabel('||f-p||_{\infty}')
legend('error','2nd order')
