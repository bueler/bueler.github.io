function obstacle(n,tol)
% OBSTACLE  Uses POPDIP to minimize
%     min   f(u)
%     s.t.  u >= 0
% for f(u) given in OBSTACLEFCN.

if nargin < 1,  n = 20;         end
if nargin < 2,  tol = 1.0e-12;  end

% solve
%x0 = 0.1 * ones(n,1);  % strictly feasible
dx = 1/(n+1);
x0 = uexact(dx:dx:1-dx) + 1;
[xk,lamk,xklist,lamklist] = popdip(x0,@obstaclefcn,tol);
fprintf('%d iterations\n',size(xklist,2))

% plot iterates
subplot(1,2,1)
dx = 1/(n+1);
x = dx:dx:1-dx;
K = min(50,size(xklist,2));
for j = 1:K-1
    plot(x,xklist(:,j),'k'), hold on
end
plot(x,xk,'r')
xlabel x, grid on

% plot exact solution and final iterate
subplot(1,2,2)
plot(x,xk,'r')
hold on
xf = 0:.001:1;
plot(xf,uexact(xf),'b')
xlabel x, grid on
end % function

    function uu = uexact(x)
    a = 0.224437973369461;  % solve  sin(2 pi a) = 0.7 (2 pi a)
    C2 = (1/(2*pi)^2) * cos(pi*(1+2*a)) - (0.7/2) * (a + 0.5) * (a - 0.5);
    uu = -(1/(2*pi)^2) * cos(2*pi*x) + (0.7/2) * x .* (x - 1) + C2;
    uu(abs(x-0.5) >= a) = 0;
    uu = 100 * uu;
    end % function
