% COMPARELU  Compare the rounding error from LUFACT (no pivoting)
% with the built-in LU (row pivoting) on random matrices of various
% sizes.  Shows the numerial errors in a single figure.  Calls LU,
% LUFACT, FORWARDSUB, and BACKSUB.

REPEATS = 5;
figure(1)
for n = [3 10 30 100 300]
    for k = 1:REPEATS
        A = randn(n,n);
        xexact = randn(n,1);
        b = A * xexact;
        [La, Ua] = lufact(A);                    % A = L U
        xa = backsub(Ua,forwardsub(La,b));       % L z = b, U x = z
        [Lb, Ub, Pb] = lu(A);                    % P A = L U
        xb = backsub(Ub,forwardsub(Lb,Pb*b));    % L z = P b, U x = z
        loglog(n,norm(xa-xexact),'bo')
        hold on
        loglog(n,norm(xb-xexact),'r+')
    end
end
xlabel n,  ylabel('error')
legend('lufact()  no pivoting',...
       'lu()      row pivoting',...
       'location','northwest')
grid on,  hold off
