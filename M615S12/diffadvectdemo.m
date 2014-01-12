function U = diffadvectdemo(J,N,tf,A,B)
% DIFFADVECTDEMO  Demonstrate new stability concern on simple
% diffusion-advection equation
%   u_t = B u_xx - A u_x
% using centered, explicit time-stepping.  Here A,B are constant.
% Compare EXPLICIT.
% Form:   U = diffadvectdemo(J,N,tf,A,B)
% Example which shows instability:
%   >> diffadvectdemo(20,30,0.03,100,1);
% Example which shows diffusion only:
%   >> diffadvectdemo(20,30,0.03,  0,1);
% Example which shows stable advection:
%   >> diffadvectdemo(20,30,0.03, 10,1);
% Example which shows just-unstable advection:
%   >> diffadvectdemo(20,30,0.03, 50,1);

dt = tf / N;   % equivalently: tf = N dt
dx = 1.0 / J;
mu = B * dt / dx^2;
fprintf('old stability condition:  mu = %.3f < 1/2 ?\n',mu);
nu = A * dt / dx;
fprintf('new stability condition:  mu = %.3f >= %.3f = nu/2 ?\n',mu,nu/2);
x = 0:dx:1;
t = 0:dt:tf;

U = zeros(N+1,J+1); % allocate space
U(1,:) = sin(4*pi*x);  % set initial condition

% numerically-approximate PDE
for n = 1:N
  for j = 2:J
    U(n+1,j) = U(n,j) + mu * (U(n,j+1) - 2 * U(n,j) + U(n,j-1)) ...
               - (nu/2) * (U(n,j+1) - U(n,j-1));
  end
end

mesh(x,t,U)
xlabel x, ylabel t, zlabel U
