function x = newt(f,df,x0,tol)
% NEWT   Illustration from in-class work on 28 Sept of using fprintf().

xold = x0;
fprintf('n  x                  |f(x)|\n')
fprintf('%d  %.15f  %.1e\n',0,xold,abs(f(xold)))
for n = 1:20
    x = xold - f(xold) / df(xold);
    fprintf('%d  %.15f  %.1e\n',n,x,abs(f(x)))
    if 5 * abs(x - xold) <= tol
        break
    end
    xold = x;
end
