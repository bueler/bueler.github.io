% OBSTACLE  Uses POPDIP to minimize
%     min   f(u)
%     s.t.  u >= 0
% for f(u) given in OBSTACLEFCN.

n = 20;
tol = 1.0e-12;

x0 = 0.1 * ones(n,1);  % strictly feasible
[xk,lamk,xklist,lamklist] = popdip(x0,@obstaclefcn,tol);

dx = 1/(n+1);
x = dx:dx:1-dx;
K = size(xklist,2);
subplot(1,2,1)
for j = 1:K-1
    plot(x,xklist(:,j),'k'), hold on
end
plot(x,xklist(:,K),'r')
xlabel x, grid on
subplot(1,2,2)
plot(x,xk,'r')
xlabel x, grid on

