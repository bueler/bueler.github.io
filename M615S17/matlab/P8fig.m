% P8FIG  Produce the figure requested in problem P8 on Assignment #2.

h = [1.0 0.5 0.1 0.05 0.01 0.005];
Z = [56.859  21.694  1.1081  1.1101  0.096909  0.011051];
c = polyfit(log(h),log(Z),1)
Zline = exp(c(2) + c(1)*log(h));
loglog(h,Z,'ko',h,Zline,'k--')
axis tight
