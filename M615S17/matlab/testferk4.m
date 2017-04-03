% TESTFERK4  test Forward Euler and Runge-Kutta order 4 for problem P26(b)

f = @(u,t) [u(2); -u(1)];  eta = [1; 0];
jj = 1:8;  NN = 2.^jj;  kk = 2.0 ./ NN;
for j = jj
    [tt,zz] = forwardeuler(f,eta,0,2,NN(j));
    errFE(j) = norm(zz(:,end) - [cos(2); -sin(2)]);
    [tt,zz] = rk4(f,eta,0,2,NN(j));
    errRK4(j) = norm(zz(:,end) - [cos(2); -sin(2)]);
end

loglog(kk,errFE,'ko',kk,errRK4,'k*')
pFE = polyfit(log(kk),log(errFE),1);
hold on,  loglog(kk,exp(pFE(1)*log(kk)+pFE(2)),'k--')
text(kk(7),0.2*errFE(6),sprintf('O(k^{%.3f})',pFE(1)),'fontsize',20)
loglog(kk,exp(pRK4(1)*log(kk)+pRK4(2)),'k--')
pRK4 = polyfit(log(kk),log(errRK4),1);
text(kk(6),0.2*errRK4(6),sprintf('O(k^{%.3f})',pRK4(1)),'fontsize',20)

hold off,  grid on,  xlabel k,  ylabel('numerical error')
axis([5.0e-3 2.0 1.0e-11 4.0])
