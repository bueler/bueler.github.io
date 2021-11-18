% EXER561E  Do Exercise 5.6.1 (e) from Driscoll & Braun.

f = @(x) sqrt(1 - x.^2);
n = 10 * 2.^(1:10);
for k = 1:10
    E(k) = abs(trapezoid(f,0,1,n(k)) - pi/4);
end
loglog(n,E,'o:',n,n.^(-2),'--')
xlabel n,  ylabel('error')
legend('observed', '2nd-order')
axis tight