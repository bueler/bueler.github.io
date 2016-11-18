function fiveroots(N,maxiters)
% FIVEROOTS Use NEWTONSOLVE on an example, with a grid of starting points,
% and illustrate with colors.  Compare results WITH line search and NOT.
% Line search uses square-of-residuals merit function, (11.35) in
% Nocedal & Wright.  The example has these n=2 equations
%     x_1 - x_2^2 + 3 = 0
%    3 cos(x_1) + x_2 = 0
% It is clear there are five roots, and maybe a sixth.
%
% Usage:
%     fiveroots(N,maxiters)
% where
%     N         grid of NxN points on rectangle [-5,8] x [-5,5] are used as
%               starting points [default = 21]
%     maxiters  run this many Newton iterations at most [default = 60]

% the example
r = @(x) [x(1) - x(2)^2 + 3;
          3*cos(x(1)) + x(2)];
J = @(x) [1,            -2*x(2);
          -3*sin(x(1)),       1];
rect = [-5 8 -5 5];
nrt = 6;
xrt = [-1.92387   1.03736;
       -1.09236  -1.38117;
        0.85707  -1.96394;
        2.46416   2.33755;
        3.67478   2.58356;
        6.22829  -3.03791];  % 6th root may or may not be false

if nargin < 1,  N = 21;  end
if nargin < 2,  maxiters = 60;  end

function z = idroot(x)
    % IDROOT  identify which root
    for j = 1:nrt
        if norm(x - xrt(j,:)') < 1.0e-2
            z = j;
            return
        end
    end
    z = 0;
end

% generate x0 and test on N x N grid
atol = 1.0e-8;
Abt = zeros(N,N);
Ano = zeros(N,N);
Arc = zeros(N,N);
x1 = linspace(rect(1),rect(2),N)';
x2 = linspace(rect(3),rect(4),N)';
for l = N:-1:1
    for k = 1:N
        x0 = [x1(k) x2(l)]';
        x = newtonsolve(x0,r,J,atol,maxiters,'bt');
        ji = idroot(x);
        Abt(l,k) = ji;
        if ji > 0
            fprintf('%d',ji)  % 1,...,nrt  represent root
        else
            if (cond(J(x)) > 1.0e6) & (norm(r(x)) > 2*atol)
                fprintf('.')  % x is where  J(x)' r(x) = grad f(x) = 0,
                              %   but  r(x) != 0  and  J(x) singular
            else
                fprintf(' ')  % otherwise; unknown case
            end
        end
        x = newtonsolve(x0,r,J,atol,maxiters,'rcmbt');
        Arc(l,k) = idroot(x);
        x = newtonsolve(x0,r,J,atol,maxiters,'none');
        Ano(l,k) = idroot(x);
    end
    fprintf('\n')
end

% change jet to make unknowns into white
cm = colormap('jet');
cm(1,:) = [1 1 1];

% generate two figures from Als, Ano
for fn = 1:3
    figure(fn)
    switch fn
        case 1
            imagesc(x1,x2,Abt)
            title('backtracking line search')
        case 2
            imagesc(x1,x2,Arc)
            title('rcond/merit backtracking line search')
        case 3
            imagesc(x1,x2,Ano)
            title('NO line search')
        otherwise
            error('unknown fn case')
    end
    set(gca,'ydir','normal')
    colormap(cm),  colorbar,  hold on
    plot(x2.^2-3,x2,'k')
    plot(x1,-3*cos(x1),'k')
    axis([-5 8 -5 5]), 	grid on,  xlabel x,  ylabel y
    for j = 1:nrt
	    plot(xrt(j,1),xrt(j,2),'ko')
	    h = text(xrt(j,1)+0.3,xrt(j,2),num2str(j));
	    set(h,'fontsize',20)
    end
    hold off
end

end
