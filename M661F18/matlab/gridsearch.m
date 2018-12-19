function gridsearch(f,x1,x2,tol)
% GRIDSEARCH  Solve 2D global minimization problems by combining a grid search
% with steepest descent (SDBT).
% Usage:
%    gridsearch(f,x1,x2,tol)
% where
%    f   = handle for function which returns f and gradient of f (see SDBT)
%    x1  = list of x_1 coordinates for initial points
%    x2  = ...     x_2 ...
%    tol = tolerance for SDBT [default: 1.0e-6]
% Example:  problem F4 does
% >> gridsearch(@f4fcn,-9:10,-9:10,1.0e-6)
% Requires:  SDBT

if nargin < 4,  tol = 1.0e-6;  end

% search, saving all f-values, and running minimum of f(x), and best x
fprintf('searching using a grid of %d initial points x_0 ...\n',...
        length(x1)*length(x2))
fval = zeros(20,20);
fstar = 1.0e6;  % larger than max
for j = 1:length(x1)
    for k = 1:length(x2)
        x0 = [x1(j); x2(k)];
        xk = sdbt(x0,f,tol,100);   % set maxiters = 100 (for speed)
        fval(j,k) = f(xk);
        if fval(j,k) < fstar
            fstar = fval(j,k);
            xstar = xk;
        end
    end
end
fprintf('global minimum:  f(%.6f,%.6f) = %.6f\n',xstar(1),xstar(2),fstar)

% first draw contour map of solution
figure(1),  clf,  hold on
N = 201;
x1f = linspace(min(x1),max(x1),N);   % finer grid for contour/mesh plotting
x2f = linspace(min(x2),max(x2),N);
zz = zeros(N,N);
for j = 1:N
    for k = 1:N
        zz(j,k) = f([x1f(j); x2f(k)]);
    end
end
contour(x1f,x2f,zz','k')
% next show xstar and those x0 that yielded xstar
plot(xstar(1),xstar(2),'r*','markersize',12)
for j = 1:length(x1)
    for k = 1:length(x2)
        if fval(j,k) <= fstar + tol
            plot(x1(j),x2(k),'bo','markersize',6)
        end
    end
end
axis([-10.5 10.5 -10.5 10.5]),  axis tight,  grid on
xlabel('x_1','fontsize',16),  ylabel('x_2','fontsize',16)

% draw surface (mesh) plot of objective function
figure(2),  clf,  hold on
mesh(x1f,x2f,zz')
view(3),  axis tight
xlabel('x_1','fontsize',16),  ylabel('x_2','fontsize',16)
zlabel('f(x)','fontsize',16)

