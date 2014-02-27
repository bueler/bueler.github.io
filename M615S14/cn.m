function err = cn(J)
% CN is the Crank-Nicolson method on this problem:
%   u_t = u_xx,   u(0,t) = u(1,t) = 0,   u(x,0) = sin(3 pi x)
% Do
%   >> cn(J)
% This code uses sparse storage and scales to high resolution.
% It returns the relative maximum error at the final time.
%
% Example: Coarse grids; suggest uncommenting plot commands for these:
%   >> cn(5)
%   >> cn(10)
%   >> cn(20)
%
% Example: Generate convergence graph, in dx-versus-error plane.
% Uses log scaling on axes, and fits a line to the data to
% see that the scheme converges at the O(dx^2) rate we seek:
%   >> JJ = [10 20 40 80 160 250 500 1000 2000 4000 8000];
%   >> for s = 1:length(JJ),  err(s) = cn(JJ(s));  end 
%   >> dx = 1./JJ;  loglog(dx,err,'r*')
%   >> xlabel('\Delta x'),  ylabel('error'),  grid on
%   >> p = polyfit(log(dx),log(err),1)
%   >> hold on,  loglog(dx,exp(p(2) + p(1)*log(dx)),'b--'),  hold off
% In this case I get p(1) = 2.04638 so the method converges at
% rate O(dx^2.04638), as expected from the theory, namely O(dx^2).

dx = 1 / J;
tf = 0.1;      % final time
dt = tf / J;   % since scheme converges unconditionally, N = J is fine
mu = dt / dx^2;

% assemble matrix
A = sparse(J+1,J+1);
A(1,1) = 1;
A(J+1,J+1) = 1;
for j = 2:J
  A(j,j-1) = -0.5*mu;
  A(j,j)   = 1 + mu;
  A(j,j+1) = -0.5*mu;
end
% debug hint: for small J, look at A by either full(A) or spy(A)

% timestep to final time
x = 0:dx:1;            % 1 by J+1  (row)
b = zeros(J+1,1);      % column
U = sin(3 * pi * x)';  % column
for n = 1:J
  b(2:J) = U(2:J) + 0.5 * mu * ( U(3:J+1) - 2 * U(2:J) + U(1:J-1) );
  b(1) = 0;
  b(J+1) = 0;
  % to solve:  A U^{n+1} = b
  U = A \ b;
end

uexact = exp(-3^2 * pi^2 * tf) * sin(3 * pi * x');
err = max(abs(U - uexact)) / max(abs(uexact));

% uncomment next line to look at final time solution:
%plot(x,U,'o-',x,uexact,'*'),  xlabel('x'), legend('numerical','exact')

