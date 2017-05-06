% F3CONV  Show convergence graph for TRBDF2 and RK2.

% problem and exact solution
U0 = [1; 1; 1];
A = [ 0,   1,    1;
     -1,   0,    1;
      0,   0, -200];
Uexact = @(t) [(1/40001) * (-199*exp(-200*t) + 40202*sin(t) + 40200*cos(t));
               (1/40001) * (-201*exp(-200*t) - 40200*sin(t) + 40202*cos(t));
               exp(-200*t)];

klist = [0.1 0.05 0.02 0.01 0.005 0.002 0.001];
f = @(x,t) A * x;  % needed for RK2
for method = 1:2
    for j = 1:length(klist)
        if method == 1
            U = trbdf2(A,U0,klist(j),1.0);
        else
            [tt,zz] = rk2(f,U0,0.0,1.0,1.0/klist(j));
            U = zz(:,end);
        end
        err(j) = norm(U - Uexact(1.0));
        if err(j) >= 1.0
            printf('WARNING: large error %.4e for method=%d and k=%d\n',...
                   err(j),method,klist(j))
        end
    end
    klist = klist(err<1.0);  err = err(err<1.0);
    p = polyfit(log(klist),log(err),1);
    loglog(klist,err,'ko',klist,exp(p(1)*log(klist)+p(2)),'k--'),  hold on
    text(klist(end-1),(3*(method-1)+0.75)*err(end-1),sprintf('O(k^{%.4f})',p(1)))
end
hold off,  grid on,  xlabel k,  ylabel('numerical error')
axis([0.001 0.1 1.0e-8 1.0e-3])
set(gca(),'xtick',[0.001, 0.01, 0.1],'xticklabel',{'0.001','0.01','0.1'},...
          'ytick',10.^(-8:-3),'xminorgrid','off','yminorgrid','off')
