function [x, U] = leapfrog(m,a,k,tf,geteigerr)
% LEAPFROG Use the midpoint and centered-space method on advection equation
%     u_t + a u_x = 0
% for u(x,t), with periodic boundary conditions on [0,1] and fixed
% initial condition u(x,0)=sin(6 pi x).  Uses m+1 grid points and a spatial
% grid with h = 1/(m+1).  Forms the matrix A in the MOL system
%     U'(t) = A U(t).
% Uses time steps k and final time tf to solve the problem.  First step is
% by RK2 which is also second order, and one step of an unstable method
% is probably not bad if the initial condition is smooth.
% Usage:  [x, u] = leapfrog(m,a,k,tf,geteigerr);

if nargin < 5,  getargerr = false;  end

% generate space grid, matrix A, and time-step
h = 1.0 / (m+1);
x = (0:h:1.0-h)';         % interpret as periodic grid
A = spdiags([-ones(m+1,1), zeros(m+1,1), ones(m+1,1)], [-1, 0, 1],m+1,m+1);
A(m+1,1) = 1.0;  A(1,m+1) = -1.0;
% full(A)                 % check pattern of A
A = - (a/(2.0*h)) * A;
NN = round(tf / k);       % must supply tf/k integer to get  k NN = tf

% optional check on eigs of A
if geteigerr
    % computed eigenvalues of A (lam) vs. formula (10.11) in book (lamex)
    lam = sort(imag(eig(A)));
    pp = (1:m+1)';
    lamex = sort(imag(- i * (a/h) * sin(2.0*pi*pp*h)));
    fprintf('eigenvalue norm difference = %.2e\n',norm(lam-lamex))
end

% solve advection equation
Uold = sin(6.0 * pi * x);      % fixed initial condition
U = Uold + (k/2) * A*Uold;     % first step is RK2, equation (5.30)
U = Uold + k * A*U;
for n = 2:NN
    Unew = Uold + 2.0*k * A*U; % leapfrog is a multi-step scheme
    Uold = U;
    U = Unew;
    fprintf('.')
end
fprintf('\n')
