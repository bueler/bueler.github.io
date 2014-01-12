% CONVERGESEMIIMP  Produce clear evidence that SEMIIMPERR has a good
% implementation of the numerical method, and a correct exact solution, too!

J = [100 200 400 800 1600];
err = zeros(1,5);
for j=1:5
  N = 50 * 4^(j-1);     % = 50, 200, 800, 3200, 12800
  err(j) = semiimperr(J(j),N,0.5);
  fprintf('case %d:  J = %4d, N = %5d  gives  error = %.3e\n',...
          j, J(j), N, err(j))
end

dx = pi ./ J;
p = polyfit(log(dx),log(err),1);    % linear fit to log-log data

loglog(dx,err,'o','markersize',14)
hold on
loglog(dx,exp(p(1)*log(dx)+p(2)),'r--')
hold off
xlabel('dx'),  ylabel('error |U - uexact|')
title(sprintf('red line is O(dx^{%f})',p(1)))

