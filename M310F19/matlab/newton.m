function x = newton(f,df,x0,tol)
% NEWTON Solve  f(x) = 0  using Newton's method,
%   x_n+1 = x_n - f(x_n) / df(x_n)
% starting from point x0 until  |x_n+1 - x_n| < tol.
% Example:
%   >> f = @(x) x.^3 - 7*x + 2;
%   >> df = @(x) 3*x.^2 - 7;
%   >> format long             % to see the correct digits grow
%   >> x = newton(f,df,0.5,1.0e-10)
%   >> f(x)                    % it should be small

if tol <= 0
  error('tol>0 is required')
end

xold = x0;
for n = 1:100
    x = xold - f(xold) / df(xold);
    fprintf('  x_%d = %.15f\n',n,x)
    if abs(x - xold) < tol
        return
    end
    xold = x;
end

