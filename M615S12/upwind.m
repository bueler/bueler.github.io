function U=upwind(J,xA,xB,tf,a,bdry,u0);
% UPWIND  Upwind method for linear advection
%    u_t + a(x,t) u_x = 0,    xA < x < xB,
%    u(x,0) = u0(x).
% Requires function a=a(x,t) and u=bdry(x,t);
% bdry is only evaluated at the points on the boundary
% where the characteristics are coming in.  Produces plot 
% of approx. soln at tf and of initial condition.
% Form:
%   >> u=upwind(J,xA,xB,tf,a,bdry,u0);
% Example (see exer 4.1 in Morton & Mayers):
%   >> a=inline('x-(1/2)','x','t') % characteristics out at bdry
%   >> bdry=inline('0','x','t')  % never evaluated (by above)
%   >> J=50; xA=0.0;  xB=1.0;  x=linspace(xA,xB,J+1);
%   >> u0=x.*(1-x);
%   >> u=upwind(J,xA,xB,1.0,a,bdry,u0);
%   >> x0=(x-0.5)*exp(-1.0)+0.5;  % for exact solution
%   >> hold on, plot(x,x0.*(1-x0)), hold off, axis([0 1 0.2 0.25])
% Example, cont.:
%   >> a=inline('(1/2)-x','x','t')  % chars in at bdry; bdry conds used
%   >> u=upwind(J,xA,xB,1.0,a,bdry,u0);
%   >> x0=(x-0.5)*exp(1.0)+0.5;  % for exact solution
%   >> hold on, plot(x,x0.*(1-x0)), hold off, axis([0 1 0 0.25])
% ELB 4/2/05

numax=0.5; % so  dt <= numax * dx / max(|a|)
x=linspace(xA,xB,J+1);   dx=abs(xB-xA)/J;
if length(u0) ~= J+1, error('length of u0 must be J+1'), end
U=u0;  % set initial condition

jj=2:J;  t=0.0;  Unew=zeros(size(u0));  itermax=100000;
for n=1:itermax
    aa=a(x,t);  maxa=max(abs(aa));
    dt=numax*dx/maxa;  nu=(dt/dx)*aa;
    if dt< 1e-6*tf, error('very small time step: < 1e-6*tf'), end
    if aa(1)>0,  Unew(1)=bdry(xA,t);  % char. in at left end
    else,  Unew(1) = (1+nu(1)) * U(1) - nu(1) * U(2);  end
    if aa(J+1)<0,  Unew(J+1)=bdry(xB,t);  % char. in at right end
    else,  Unew(J+1) = (1-nu(J+1)) * U(J+1) + nu(J+1) * U(J);  end
    upL=jj(aa(2:J)>=0);  upR=jj(aa(2:J)<0);
    Unew(upL) = (1-nu(upL)) .* U(upL) + nu(upL) .* U(upL-1);
    Unew(upR) = (1+nu(upR)) .* U(upR) - nu(upR) .* U(upR+1);
    U=Unew;   
    if t >= tf, break, end
    t=t+dt;   if t > tf, t=tf; end
end

disp(['number of steps = ' num2str(n)])
plot(x,u0,'--',x,U,'.-')
legend('initial condition','approx. soln. at t_f')

