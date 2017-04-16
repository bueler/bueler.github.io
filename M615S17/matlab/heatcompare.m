function heatcompare(m,NN,tf)
% HEATCOMPARE Compute the backward Euler (BE) solution of the heat equation
% problem
%   u_t = u_xx,  u(t,0) = u(t,1) = 0,  u(0,x) = u_0(x)
% which becomes a linear ODE system
%   U' = A U
% when discretized by method-of-lines.  Here U(t) is a column vector of size m.
% Compute and report the stable time step of forward Euler (FE).  Reports
% computational costs for both forward Euler (FE) and (BE).
% Usage:  heatcompare(m,N,tf)
% where m = number of space points, N = number of time steps, tf = final time.

% generate A and its eigenvalues
h = 1.0 / (m+1);
A = (1/h^2) * spdiags([ones(m,1), -2*ones(m,1), ones(m,1)], [-1, 0, 1],m,m);
lam = eig(A);

% FE time restriction:  z = k lambda >= -2  for all eigenvalues lambda
kFE = 2.0 / abs(min(lam));
% note one step of FE would be  U^{n+1} = (I + k A) U^n
NFE = ceil(tf / kFE);

% actually do BE; linear system is   (I - k A) U^{n+1} = U^n
kBE = tf / NN;
x = h:h:1-h;
U = zeros(m,1);  U((x > 0.25) & (x < 0.5)) = 1.0;
subplot(1,2,1),  plot(x,U,'k'),  xlabel x,  grid on,  title('initial')
for n = 1:NN
    U = (speye(m,m) - kBE * A) \ U;
end
subplot(1,2,2),  plot(x,U,'k'),  xlabel x,  grid on, title('final')

% report computational costs
fprintf('       stable time step for FE:  kFE = %.3e\n',kFE)
fprintf('         time step used for BE:  kBE = %.3e\n',kBE)
fprintf('  cost of FE (multiplications):  %d\n',NFE * 3 * m)
fprintf('  cost of BE (multiplications):  %d\n',NN * 5 * m)
