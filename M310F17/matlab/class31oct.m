% CLASS31OCT  Computations done in class for trapezoid rule (section 2.5)
% and corrected trapezoid rule (section 5.2).  During class I wrote
% trap.m with signature
%     function z = trap(f,a,b,n)
% and bettertrap.m with
%     function z = bettertrap(f,df,a,b,n).
% Running this requires you have also created those functions.

format long g

% do integral of straight line on [7,12]; trapezoid should be exact:
f = @(x) 1+3*x;
exact = 5 + (3/2)*(144-49)
trap(f,7,12,1)
trap(f,7,12,5)

% do integral of generic function on [-1,3]:
f = @(x) x * exp(-x);
exact = -4*exp(-3)
trap(f,-1,3,20)   % how do we tell if trap is right?
                  % ... hard to tell from just this number

% generate results which should converge to the exact:
for n = [2 4 8 16 32 64 128],  trap(f,-1,3,n),  end

% actually measure the errors:
nlist = [2 4 8 16 32 64 128 256 512 1024];
for i = 1:10
    n = nlist(i);
    err(i) = abs(trap(f,-1,3,n) - exact);
end
err

% generate figure showing errors versus h:
hlist = 4 ./ nlist;
loglog(hlist,err,'*')
xlabel('h')
ylabel('numerical error from trap')
grid on

% do errors converge to zero at correct rate?  measure the rate and plot:
p = polyfit(log(hlist),log(err),1)
% p(1) = 1.988 so we know that errors go like  O(h^2)  ... so trap.m is correct
hold on
loglog(hlist,exp(p(2)+p(1)*log(hlist)),'r--')
hold off
text(1e-2,1e-2,'O(h^{1.988})')

% different topic:  show corrected/improved trapezoid rule (bettertrap) is better
df = @(x) (1-x) * exp(-x);
trap(f,-1,3,128)
bettertrap(f,df,-1,3,128)
abs(trap(f,-1,3,128) - exact)
abs(bettertrap(f,df,-1,3,128) - exact)
abs(trap(f,-1,3,10000) - exact)
abs(bettertrap(f,df,-1,3,10000) - exact)

