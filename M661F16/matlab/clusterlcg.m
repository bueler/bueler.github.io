% CLUSTERLCG  Demonstrate behavior of LCG on A with clustered eigenvalues.

n = 30;                                                             % step (i)
D = diag([100, 110, 140, 200, 400, linspace(0.95,1.05,n-5)]);

[Q,R] = qr(randn(n));                                               % step (ii)
norm(Q'*Q-eye(n))        % shows Q almost-exactly orthogonal

A = Q'*D*Q;                                                         % step (iii)
norm(A-A')               % shows A almost-exactly symmetric
A = (A + A') / 2;        % make it exactly symmetric
[L,ifail] = cholesky(A);
ifail                    % < 0; shows A is SPD

xstar = ones(n,1);                                                  % step (iv)
b = A * xstar;

[x xlist] = lcg(zeros(n,1),A,b,1.0e-13,12);                         % step (v)
KK = size(xlist,2)       % number of iterations
err = ones(1,KK);
for k=1:KK
    err(k) = (xlist(:,k)-xstar)' * A * (xlist(:,k)-xstar);
end

semilogy(1:KK,err,'ko-') % make better-looking graph
set(gca,'ytick',10.^(-14:2:4))
xlabel('iteration k'),  ylabel('error |x_k - x^*|_A^2')
