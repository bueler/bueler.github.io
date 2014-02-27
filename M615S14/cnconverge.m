% CNCONVERGE  show plot of convergence of Crank-Nicolson program CN

JJ = [10 20 40 80 160 250 500 1000 2000 4000 8000];
for s = 1:length(JJ)
  err(s) = cn(JJ(s));
end 
dx = 1./JJ;
loglog(dx,err,'r*')
xlabel('\Delta x'),  ylabel('error'),  grid on
p = polyfit(log(dx),log(err),1)
hold on,  loglog(dx,exp(p(2) + p(1)*log(dx)),'b--'),  hold off

