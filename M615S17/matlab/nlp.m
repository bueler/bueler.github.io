function [x,y,U,err] = nlp(m,gamma,f)
% NLP  Solve the nonlinear Poisson equation
%   u_xx + u_yy + gamma u^4 = f(x,y)
% on the unit square, with zero Dirichlet boundary conditions (u=0 on boundary).
% Uses manufactured solution to compute error.  Requires PASSEMBLE.
% Usage:   [x,y,UU,err] = nlp(m,gamma)
%          [x,y,UU] = nlp(m,gamma,f)       % general case for any f(x,y)
% Example:
%   >> [x,y,UU,err] = nlp(10,10.0);  surf(x,y,UU)

if nargin < 3
    % manufactured solution
    uexact = @(x,y) sin(pi * x) .* sin(3 * pi * y);
    f = @(x,y) - 10 * pi^2 * uexact(x,y) + gamma * uexact(x,y).^4;
end
[x,y,A,frhs] = passemble(m,f);
h = 1.0 / (m+1);  N = m^2;

% Newton iteration
U = zeros(N,1);
for knewt = 1:15
    FF = A * U + gamma * U.^4 - frhs;
    rnorm = norm(FF);
    printf('    %2d:  residual norm %.4e\n',knewt-1,rnorm)
    if knewt == 1,  rnorm0 = rnorm;  end
    if (rnorm / rnorm0) < 1.0e-9,  break;  end
    JJ = A + spdiags(4 * gamma * U.^3,0,N,N);
    s = - JJ \ FF;                % Newton step
    U = U + s;
end

if nargin < 3
    [xx,yy] = ndgrid(x,y);
    Uex = reshape(uexact(xx,yy),N,1);
    err = norm(U-Uex,'inf');
    printf('error on m=%d grid with h = %.5f:  |U-Uexact|_inf = %.3e\n',...
           m,h,err);
end
U = reshape(U,m,m);
