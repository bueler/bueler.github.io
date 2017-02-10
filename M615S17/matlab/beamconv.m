% BEAMCONV  plot convergence and conditioning data for BEAM

m = [5, 10, 20, 40, 100, 200, 400, 1000, 2000, 3000];
h = 1.0 ./ (m+1);
condA = [4.59e+01 4.82e+02 6.27e+03 9.05e+04 3.33e+06 5.22e+07 8.27e+08 3.21e+10 5.12e+11 2.59e+12];
errinf = [4.992871e-03 1.577625e-03 4.425545e-04 1.175073e-04 1.938672e-05 4.896446e-06 1.230393e-06 1.994954e-07 8.295480e-08 3.035143e-07];
loglog(h,errinf,'k.-','markersize',16,
       h,condA,'ko:','markersize',12)
pe = polyfit(log(h(1:8)),log(errinf(1:8)),1);
text(1.5e-2,2.0e-3,sprintf('O(h^{%.2f})',pe(1)),'fontsize',14)
pc = polyfit(log(h),log(condA),1);
text(2.0e-3,1.0e7,sprintf('O(h^{%.2f})',pc(1)),'fontsize',14)
legend('error ||U-uexact||','cond(A)')
xlabel h
axis tight
print -dpdf beamconv.pdf

