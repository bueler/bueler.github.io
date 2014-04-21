% POROUSCONVERGEFIG generate a figure showing the convergence of POROUS
% on the problem for which BARENBLATT is the exact solution

JJ = [20 40 100 200 400 1000 2000];

dx = zeros(1,length(JJ));
averr = dx;  maxerr = dx;                    % allocate space

for k = 1:length(JJ)
    fprintf('J = %d:\n',JJ(k))
    x = linspace(-10,10,JJ(k)+1);            % grid with JJ(k) equal spaces
    [Uerr, dx(k), averr(k), maxerr(k)] = porous(x,0.1,10);
    close all
end

% estimate convergence rate
pmax = polyfit(log(dx),log(maxerr),1);
fprintf('maximum errors converge at rate  O(dx^{%.2f})\n',pmax(1))
pav = polyfit(log(dx),log(averr),1);
fprintf('average errors converge at rate  O(dx^{%.2f})\n',pav(1))

% make figure
loglog(dx,maxerr,'k*','markersize',12,...
       dx,averr,'ko','markersize',10)
legend('max |U_j - u(x_j,t_f)|','average |U_j - u(x_j,t_f)|',...
       'location','southeast')
hold on
loglog(dx,exp(pmax(1)*log(dx)+pmax(2)),'k:')
loglog(dx,exp(pav(1)*log(dx)+pav(2)),'k--')
hold off,  grid on
ylabel('error','fontsize',16)
xlabel('\Delta x','fontsize',16)
axis([0.5*min(dx), 2.0*max(dx), 0.5*min(averr), 2.0*max(maxerr)])
set(gca,'xtick',[1e-2 1e-1 1])
set(gca,'xticklabel',{'0.01','0.1','1.0'})
