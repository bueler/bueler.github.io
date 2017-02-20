% TESTSOLVEP12  Generate convergence plot, with rate, for SOLVEP12

mlist = [5 10 20 50 100 200 500 1000 2000 5000 10000];
K = length(mlist);
errs  = zeros(1,K);
times = zeros(1,K);
for s = 1:K
    tic,  [x,U,A,errs(s)] = solveP12(mlist(s));
    times(s) = toc;
end
h = 1.0 ./ mlist;
p = polyfit(log(h),log(errs),1);
fiterr = exp(p(2) + p(1) * log(h));
loglog(h,errs,'ko',h,times,'k*',h,fiterr,'k--')
text(h(6),10*errs(6),sprintf('O(h^{%.2f})',p(1)))
xlabel h,  ylabel('errors (o) and times (*)')
axis tight
