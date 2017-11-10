% RATESPERIODIC   Compare convergence rates for trapezoid rule in cases
% where the function is, and is not, periodic.

fper = @(x) exp(sin(pi * x));
exactper = 2.53213175550403;
fnot = @(x) exp(-x.^2);
exactnot = erf(2) * sqrt(pi) / 2;

nlist = [1 2 4 8 16 32];
hlist = 2 ./ nlist;
for k = 1:6
    errper(k) = abs(trap(fper,0,2,nlist(k)) - exactper);
    errnot(k) = abs(trap(fnot,0,2,nlist(k)) - exactnot);
end
loglog(hlist,errper,'ko',hlist,errnot,'k*')
legend('periodic integrand', 'non-periodic integrand','location','southeast')
ylabel('absolute error'),  xlabel h
set(gca(),'XTick',fliplr(hlist))       % put x-ticks where we have h-values
grid on,  axis tight

