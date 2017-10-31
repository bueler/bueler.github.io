% CLASS31OCT  Computations done in class for trapezoid rule and corrected
% trapezoid rule.  During class I wrote trap.m with signature
%     function z = trap(f,a,b,n)
% and bettertrap.m with
%     function z = bettertrap(f,df,a,b,n).
% Running this requires you have also created those functions.

format long g

% do integral of straight line on [7,12]:
f = @(x) 1+3*x;
exact = 5 + (3/2)*(144-49)
trap(f,7,12,1)
trap(f,7,12,5)

% do integral of generic function on [-1,3]:
f = @(x) x * exp(-x);
exact = -4*exp(-3)
trap(f,-1,3,20)   % how do we tell if trap is right? ... hard to tell from this number

% generate results which should converge to the exact:
for n = [2 4 8 16 32 64 128],  trap(f,-1,3,n),  end

% actually measure the errors:
nlist = [2 4 8 16 32 64 128 256 512 1024];
for i=1:10,  n = nlist(i);  err(i) = abs(trap(f,-1,3,n) - exact);  end
err

% generate figure showing convergence of error to zero at correct rate:
hlist = 4 ./ nlist;
loglog(hlist,err,'*')
xlabel('h')
ylabel('numerical error from trap')
grid on
p = polyfit(log(hlist),log(err),1)
hold on
loglog(hlist,exp(p(2)+p(1)*log(hlist)),'r--')
hold off
text(1e-2,1e-2,'O(h^{1.988})')

% show correct trapezoid rule is better
df = @(x) (1-x) * exp(-x);
trap(f,-1,3,128)
bettertrap(f,df,-1,3,128)
abs(trap(f,-1,3,128) - (-4*exp(-3)))
abs(bettertrap(f,df,-1,3,128) - (-4*exp(-3)))
abs(trap(f,-1,3,10000) - (-4*exp(-3)))
abs(bettertrap(f,df,-1,3,10000) - (-4*exp(-3)))

