function testleapfrog(offset)
% TESTLEAPFROG  Run convergence test on LEAPFROG.

if nargin < 1,  offset = 1;  end

a = 0.5;
tf = 10.0;
uexact = @(x) sin(6*pi*x);    % exact solution at tf

hh = [0.1 0.05 0.02 0.01 0.005 0.002];
mm = round((1.0 ./ hh))       % so  h = 1 / (m+1)
kk = hh;                      % refinement path

err = zeros(size(hh));
for j = 1:length(mm)
    [x,U] = leapfrog(mm(j),a,kk(j),tf,false);
    err(j) = norm(U - uexact(x),'inf');
end

loglog(hh,err,'ko')
hhp = hh(offset:end);  errp = err(offset:end);
p = polyfit(log(hhp),log(errp),1)
hold on,  loglog(hhp,exp(p(2) + p(1)*log(hhp)),'k--'),  hold off
text(0.003,1.1*err(4),['O(h^{' num2str(p(1)) '})'],'fontsize',16)
xlabel h,  ylabel('numerical error')
axis tight
set(gca(),'xtick',[0.1 0.05 0.02 0.01 0.005 0.002],...
          'xticklabel',{'0.1','0.05','0.02','0.01','0.005','0.002'})
grid on

