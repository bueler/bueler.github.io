function testheats(offset)
% TESTHEATS  Run convergence tests on BEHEAT and CNHEAT.

if nargin < 1,  offset = 1;  end
kappa = 1/20;
tf = 0.1;
uexact = @(x,t) exp(-25*pi^2*kappa*t) * sin(5*pi*x);
hh = [0.05 0.01 0.005 0.002 0.001 0.0005];
mm = round((1.0 ./ hh) - 1.0);   % so  h = 1 / (m+1)
kk = 2.0 * hh;                   % refinement path

for method = 1:2
    err = zeros(size(hh));
    for j = 1:length(mm)
        if method == 1
            [x,U] = beheat(mm(j),kappa,kk(j),tf);
        else
            [x,U] = cnheat(mm(j),kappa,kk(j),tf);
        end
        err(j) = norm(U - uexact(x,tf),'inf');
    end
    figure(method),  clf,  loglog(hh,err,'ko')
    hhp = hh(offset:end);  errp = err(offset:end);
    p = polyfit(log(hhp),log(errp),1)
    hold on,  loglog(hhp,exp(p(2) + p(1)*log(hhp)),'k--'),  hold off
    text(0.003,1.1*err(4),['O(h^{' num2str(p(1)) '})'],'fontsize',16)
    set(gca(),'xtick',[0.05 0.01 0.005 0.001 0.0005],...
              'xticklabel',{'0.05','0.01','0.005','0.001','0.0005'})
    xlabel h,  ylabel('numerical error'),  axis tight,  grid on
end
