function [xk, xklist] = secant1d(df,x0,x1,tol)
% SECANT1D  Solve  df(x) = 0  by the secant method.

xklist = [x0 x1];
xold = x0;
xk = x1;
for k = 2:100
    if abs(df(xk)) < tol | abs(xk - xold) < 1.0e-20
        break
    end
    p = - (xk - xold) * df(xk) / (df(xk) - df(xold));
    xold = xk;
    xk = xk + p;
    xklist = [xklist xk];
end

