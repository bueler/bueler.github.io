% COMPAREBFGS  Compare error norms coming from Newton and various BFGS
% on the ROSENBROCK example.
% Requires:  BT, NEWTONBT, BFGSNAIVE, BFGSBT, ROSENBROCK

x0 = [1.2 1.2]';
xstar = [1.0 1.0]';   % exact minimizer

tol = 1.0e-10;
method = {@newtonbt, @bfgsnaive, @bfgsbt};  % list of function handles
style = 'o*sd';                             % marker styles
for m = 1:4
    % run and get errors
    if m <= 3
        [x, xlist, alphalist] = method{m}(x0,@rosenbrock,tol);
    else
        [x, xlist, alphalist] = bfgsbt(x0,@rosenbrock,tol,100,false);
    end
    N = length(xlist(1,:));
    err = zeros(1,N);
    for j = 1:N
        err(j) = norm(xlist(:,j)-xstar);
    end
    % plot using log scaling on y axis
    semilogy(1:N,err,['k' style(m)])
    hold on
end

hold off
grid on,  xlabel k,  ylabel('error |x_k - x^*|')
legend('Newton', 'BFGS (naive)', 'BFGS (scale H0)', 'BFGS (no scale)')
set(gca,'ytick',10.^(-12:2:0))
set(gca,'yticklabel',{'10^{-12}','10^{-10}','10^{-8}','10^{-6}','10^{-4}','10^{-2}','1'})

