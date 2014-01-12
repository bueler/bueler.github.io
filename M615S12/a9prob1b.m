% A9PROB1B  Solve problem 1 (b) on final A#9 in Math 615 in Spring 2012:
%    u_t = ( p(x) u_x )_x + f(x,t)
% where p(x) = 0.5 atan(x+1) and b.c.s are u(0,t)=0 and u(1,t)=0.
% My manufactured solution:
%    u(x,t) = e^(- (pi^2/2) t) sin(pi x).
% The source function f(x,t) is chosen so this is a solution.  Uses the
% explicit method described in section 2.15: get p(x) on staggered-grid.

uex  = @(x,t) exp(-pi*pi*t/2) .* sin(pi*x);
p    = @(x)   0.5 * atan(x+1);
maxP = 0.5 * atan(2);  % = max p(x) 
f    = @(x,t) (pi/2) * exp(-pi*pi*t/2) .* ( pi * sin(pi*x) .* (atan(x+1) - 1) - ...
                                              cos(pi*x) ./ ((x+1).^2 +1) );
JJ = [20 40 80];
tf = 0.2;

figure(1), clf
for s = 1:length(JJ)
  J = JJ(s);
  dx = 1/J;  x = 0:dx:1;      % regular grid; J+1 values
  xs = (dx/2):dx:(1-(dx/2));  % staggered grid; J values
  ps = p(xs);                 % p(x) on staggered grid
  dt = 0.4 * dx^2 / maxP;     % see (2.155)
  N = ceil(tf / dt);  dt = tf / N;
  U = uex(x,0.0);             % initial cond. from exact soln.
  for n = 1:N
    U(2:J) = U(2:J) + (dt / (dx^2)) * ( ps(2:J)   .* (U(3:J+1) - U(2:J)) - ...
                                        ps(1:J-1) .* (U(2:J) - U(1:J-1))   ) + ...
                      dt * f(x(2:J),(n-1)*dt);
    U(1) = 0;  U(J+1) = 0;
  end
  exact = uex(x,tf);
  err(s) = max(abs(U-exact));
  fprintf("case J=%d,N=%d: error = %.2e\n",J,N,err(s))
  subplot(3,1,s)
  plot(x,U,'o','markersize',12,x,exact)
  xlabel x, ylabel u, legend('approx','exact')
end

p = polyfit(log(1./JJ),log(err),1);
fprintf("conclusion: convergence rate is O(dx^%.3f)\n",p(1))
