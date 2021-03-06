% NEWTONVBFGS  Compare error norms coming from NEWTONBT and BFGSNAIVE on
% on the ROSENBROCK example.

x0 = [1.2 1.2]';
%x0 = [-1.2 1.0]';    % alternative initial iterate
xstar = [1.0 1.0]';   % exact minimizer

% run Newton and get errors
[x, xlist, alphalist] = newtonbt(x0,@rosenbrock,1.0e-10);
NNEWT = length(xlist(1,:));
errNEWT = zeros(1,NNEWT);
for j = 1:NNEWT
    errNEWT(j) = norm(xlist(:,j)-xstar);
end

% run BFGS and get errors
[x, xlist, alphalist] = bfgsnaive(x0,@rosenbrock,1.0e-10);
NBFGS = length(xlist(1,:));
errBFGS = zeros(1,NBFGS);
for j = 1:NBFGS
    errBFGS(j) = norm(xlist(:,j)-xstar);
end

% plot using log scaling on y axis
semilogy(1:NNEWT,errNEWT,'ko')
hold on,  semilogy(1:NBFGS,errBFGS,'k*'), hold off
grid on,  xlabel k,  ylabel('error |x_k - x^*|')
legend('Newton','BFGS')
set(gca,'ytick',10.^(-12:2:0))
set(gca,'yticklabel',{'10^-12','10^-10','10^-8','10^-6','10^-4','10^-2','1'})
