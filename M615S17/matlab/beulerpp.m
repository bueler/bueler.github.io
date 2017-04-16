function [tt, uu] = beulerpp(eta,t0,tf,NN)
% BEULERPP  Apply the backward Euler method to a predator-prey problem.
% Usage:  [tt, uu] = beulerpp(N)
% Example:  >> [tt,uu] = beulerpp([2;2],0,20,50);  plot(tt,uu)

f = @(u) [(2/3)*u(1) - (4/3)*u(1)*u(2);       % right side of ODE:  u' = f(u)
          u(1)*u(2) - u(2)];
Jf = @(u) [(2/3) - (4/3)*u(2),   -(4/3)*u(1); % Jacobian of right side
           u(2),                 u(1) - 1];
k = tf/NN;  tt = 0:k:tf;
U0 = eta(:);
Mnewt = 4;      % trial and error shows this gives 8 to 15 digits
uu = zeros(2,1:NN+1);
uu(:,1) = U0;
for n = 1:NN
    U = uu(:,n);
    for m = 1:Mnewt
        F = U - uu(:,n) - k * f(U);
        fprintf('%.2e  ',norm(F))    % get residual norms to estimate accuracy
        JJ = eye(2,2) - k * Jf(U);
        s = - JJ \ F;
        U = U + s;
    end
    fprintf('\n')
    uu(:,n+1) = U;
end
