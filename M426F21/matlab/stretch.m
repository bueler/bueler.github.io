% STRETCH  Solve for the displacements in a weighted string stretched
% between two anchors.  See Exercise 2.6.3 in Driscoll & Braun.

% constants which don't change with n
g = -9.8;          % m s-2
tau = 10;          % N = kg m s-2

% the two superimposed plots have different n-values and styles
nvalues = [4 40];
styles = {'bs-', 'ro-'};

% loop over k=1,2 to make one figure
for k = 1:2
    n = nvalues(k);
    m = 1.0 / (10 * n);        % kg
    one = ones(n-2,1);
    A = n * tau * (diag(2*ones(n-1,1)) - diag(one,+1) - diag(one,-1));
    if k == 1,  A,  end        % show the matrix in the smaller case
    f = m * g * ones(n-1,1);
    q = A \ f;                 % solve linear system for displacements
    fprintf('n = %2d:  center drop = %.3f m\n', n, min(q))
    x = 0.0:1.0/n:1.0;         % same as:  x = linspace(0.0,1.0,n+1);
    plot(x, [0; q; 0], styles{k}),  hold on
end

% pretty-up the plot
legend('n=4', 'n=40')
xlabel('x  (m)'),  ylabel('displacement  (m)')
grid on,  hold off