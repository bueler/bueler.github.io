% POISSONCONV  Show convergence of POISSON

% run and get data
levs = 1:7;
m = 2.^levs - 1;   % = [1, 3, 7, 15, ...]
h = 1.0 ./ (m+1);  % = [0.5, 0.25, 0.125, ...]
err = zeros(size(m));
for s = 1:7
    [x,y,U,err(s)] = poisson(m(s));
end

% generate figure with O(h^p) measured rate
loglog(h,err,'ko')
p = polyfit(log(h),log(err),1);
hold on,  loglog(h,exp(p(2) + p(1)*log(h)),'k--'),  hold off
text(1.5 * h(3),1.5 * err(3), sprintf('O(h^{%.3f})',p(1)), 'fontsize', 16)
xlabel('h','fontsize',16)
axis tight
