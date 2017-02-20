function [tt, U] = pendulum(m,K,T,alpha,beta,U0)
% PENDULUM  Solve ODEBVP for nonlinear pendulum problem,
%     U''(t) = - sin(U(t))
% where U(t) is the angle (from vertical downwards) at time t, with initial-
% and final-time boundary conditions
%     U(0) = alpha,  U(T) = beta.
% Sets-up and solves a nonlinear system of equations
%     G(U) = 0
% by K iterations of Newton's method.  Generates a figure showing the iterates.
% Usage:
%     [tt, U] = pendulum(m,K,T,alpha,beta,U0)
% where
%     tt = time axis
%     U = approximate solution (= theta(t))
%     m = number of interior points in grid;  h = T / (m+1)
%     K = number of Newton iterations
%     T = length of time interval
%     alpha = U(0) = angle at t=0
%     beta = U(T) = angle at t=T
%     U0 = initial iterate; DEFAULT is straight line connecting points
% Example for Figure 2.4(b) in LeVeque FD textbook:
%   >> pendulum(100,4,2*pi,0.7,0.7);
% Example for Figure 2.5 uses different initial iterate:
%   >> m = 100;  T = 2*pi;  h = T / (m+1);
%   >> tt = (h:h:T-h)';  U0 = 0.7 + sin(tt/2);
%   >> pendulum(100,5,2*pi,0.7,0.7,U0);

h = T / (m+1);
tt = (h:h:T-h)';   % m point equally-spaced grid as a column
if nargin < 6   % by default, generate initial iterate from straight line
    U0 = alpha + (beta - alpha) / T * tt;
end

    function z = G(U)
        % G Evaluate residual in nonlinear equations.
        z = zeros(m,1);
        z(1) = (alpha - 2.0 * U(1) + U(2)) / h^2 + sin(U(1));
        for j = 2:m-1
            z(j) = (U(j-1) - 2.0 * U(j) + U(j+1)) / h^2 + sin(U(j));
        end
        z(m) = (U(m-1) - 2.0 * U(m) + beta) / h^2 + sin(U(m));
    end

    function A = J(U)
        % J Evaluate Jacobian in nonlinear equations.
        A = diag(-2.0 / h^2 + cos(U));             % A has correct diagonal
        A(1,2) = 1.0/h^2;
        for j = 2:m-1
            A(j,[j-1,j+1]) = [1.0/h^2, 1.0/h^2];   % off-diagonal entries
        end
        A(m,m-1) = 1.0/h^2;
    end

    function reportiterate(k,U,normF,normF0,normdelta)
        % REPORTITERATE  Show residual norm reduction factor and add to figure.
        if k == 1
            printf('iterate  |G(U)|/|G(U0)|  |delta|_inf\n')
        end
        if nargin < 5
            printf('%d        %.4e\n',k-1,normF/normF0)
            plot(tt,U,'k','linewidth',3.0)
        else
            printf('%d        %.4e      %.4e\n',k-1,normF/normF0,normdelta)
            plot(tt,U,'k')
        end
        m3 = floor(m/3);  % someplace along t axis to print k in figure
        text(tt(m3),U(m3)+0.05,sprintf('%d',k-1),'fontsize',16)
    end

% Newton's method
figure(1),  clf,  hold on   # start with blank figure
U = U0;
for k = 1:K
    F = G(U);
    if k == 1,  normF0 = norm(F);  end
    % could apply stopping tolerance here:  norm(F) / normF0 < tol
    delta = - J(U) \ F;   % the newton step: solve J(U) delta = - G(U)
    reportiterate(k,U,norm(F),normF0,norm(delta,'inf'));
    U = U + delta;
end
reportiterate(K+1,U,norm(G(U)),normF0);
hold off,  axis([0 ceil(T)])
end  % function pendulum
