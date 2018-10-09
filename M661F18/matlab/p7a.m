function z = p7a(f,df)
% P7A  Implement an inadequate algorithm for 1D optimization.

x = 1.0;
maxiters = 1000000;
for k = 1:maxiters
    if abs(df(x)) < 1.0e-3
        break
    end
    if df(x) > 0.0
        p = -1.0;
    else
        p = +1.0;
    end
    x = x + (0.01)*p;
end
fprintf('done in %d iterations\n',k-1)
z = x;
