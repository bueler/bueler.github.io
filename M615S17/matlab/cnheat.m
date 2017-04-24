function [x, U] = cnheat(m,kappa,k,tf)
% CNHEAT Use the trapezoid and centered-space method on the heat equation
%     u_t = kappa u_xx
% for u(x,t), with Dirichlet boundary conditions u(0,t)=u(1,t)=0 and fixed
% initial condition u(x,0)=sin(5 pi x).  Uses m interior points and spatial
% grid with h = 1/(m+1) to form the MOL matrix A.  Uses time steps k and
% final time tf to solve the problem.  Note "CN" stands for Crank-Nicolson.
% Usage:  [x, U] = cnheat(m,kappa,k,tf);

% generate space grid, matrix A, and time-step
h = 1.0 / (m+1);
x = (h:h:1.0-h)';
A = (kappa/h^2) * spdiags([ones(m,1), -2*ones(m,1), ones(m,1)],...
                          [-1, 0, 1],m,m);
NN = round(tf / k);       % must supply tf/k integer to get  k NN = tf

U = sin(5.0 * pi * x);    % fixed initial conditon
B1 = speye(m,m) - (k/2) * A;
B2 = speye(m,m) + (k/2) * A;
for n = 1:NN
    U = B1 \ B2 * U;      % the trapezoid step
    fprintf('.')
end
fprintf('\n')
