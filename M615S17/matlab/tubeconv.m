% TUBECONV  plot convergence and conditioning data for TUBE

m = [5, 10, 20, 40, 100, 200, 400, 1000, 2000, 3000];
h = 2.0 * pi ./ m;
condA = [1.23e+01 2.99e+01 6.84e+01 1.49e+02 4.48e+02 1.64e+03 6.55e+03 4.09e+04 1.64e+05 3.68e+05];
errinf = [6.162524e+00 9.528663e-01 1.658485e-01 3.932011e-02 6.176830e-03 1.539151e-03 3.844729e-04 6.150332e-05 1.537577e-05 6.833634e-06];
loglog(h,errinf,'k.-','markersize',16,
       h,condA,'ko:','markersize',12)
pe = polyfit(log(h(3:end)),log(errinf(3:end)),1);
text(1.5e-2,1.0e-2,sprintf('O(h^{%.2f})',pe(1)),'fontsize',14)
pc = polyfit(log(h),log(condA),1);
text(1.0e-2,5.0e2,sprintf('O(h^{%.2f})',pc(1)),'fontsize',14)
legend('error ||U-uexact||','cond(A)')
xlabel h
axis tight
print -dpdf tubeconv.pdf

