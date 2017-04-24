function [x, U] = beheat(m,kappa,k,tf)
% BEHEAT Use the backward Euler and centered-space method on the heat eqn
%     u_t = kappa u_xx
% for u(x,t), with Dirichlet boundary conditions u(0,t)=u(1,t)=0 and fixed
% initial condition u(x,0)=sin(5 pi x).  Uses m interior points and spatial
% grid with h = 1/(m+1) to form the MOL matrix A.  Uses time steps k and
% final time tf to solve the problem.
% Usage:  [x, U] = beheat(m,kappa,k,tf);

% generate space grid, matrix A, and time-step
h = 1.0 / (m+1);
x = (h:h:1.0-h)';
A = (kappa/h^2) * spdiags([ones(m,1), -2*ones(m,1), ones(m,1)],...
                          [-1, 0, 1],m,m);
NN = round(tf / k);       % must supply tf/k integer to get  k NN = tf

U = sin(5.0 * pi * x);    % fixed initial conditon
B = speye(m,m) - k * A;
for n = 1:NN
    U = B \ U;            % the backward Euler step
    fprintf('.')
end
fprintf('\n')
