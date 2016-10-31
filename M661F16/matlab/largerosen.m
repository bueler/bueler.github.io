function largerosen(n)
% LARGEROSEN  Show error norms coming from NEWTONBT and BFGSBT on the
% XROSENBROCK function in dimension n.  (Default: n = 100)
% Requires:  BFGSBT, XROSENBROCK

if nargin < 1,  n = 100;  end
x0 = 1.0 + randn(n,1);   % mean 1, std dev 1
xstar = ones(n,1);       % exact minimizer

tol = 1.0e-8;
maxit = 1000;
method = {@newtonbt, @bfgsbt};  % list of function handles
methodname = {'Newton','BFGS'};
style = 'o*';                 % marker styles
for q = 1:2
   fprintf('starting %s on Rosenbrock function in dimension n = %d ...\n',...
           methodname{q},n)
   tic
   [x, xlist, alphalist] = method{q}(x0,@xrosenbrock,tol,maxit);
   fprintf('    ... finished in %.4f seconds\n',toc)
   % compute errors
   M = size(xlist,2);
   fprintf('    %d iterations gives  ||x-x^*|| = %.2e\n',M,norm(x-xstar))
   err = zeros(1,M);
   for j = 1:M
       err(j) = norm(xlist(:,j)-xstar);
   end
   semilogy(1:M,err,['k' style(q)])
   hold on
end

% plot using log scaling on y axis
hold off
grid on,  xlabel k,  ylabel('error |x_k - x^*|')
legend(methodname)
set(gca,'ytick',10.^(-12:2:0))
set(gca,'yticklabel',{'10^{-12}','10^{-10}','10^{-8}','10^{-6}','10^{-4}','10^{-2}','1'})

