% EXERCISE3P5N5  Do exercise 5 in section 3.5.

f = @(x) 2 - exp(x);
df = @(x) - exp(x);
ddf = @(x) - exp(x);

alpha = log(2);                     % exact:  f(alpha) = 0
% Cexact = - ddf(alpha) / (2 * df(alpha))
 
plist = [1.0 1.8 2.0 2.2 3.0];      % test quadratic, and nearby, orders
fprintf('  ')
for p = plist
    fprintf('           %3.1f',p)
end
fprintf('\n')

x = 1.0;                            % have to pick some initial iterate
for k = 1:4
    fprintf('%d:  ',k)
    xnew = x - f(x) / df(x);
    for p = plist
        fprintf('%12.4f  ',abs(alpha-xnew)/(abs(alpha-x))^p)
    end
    fprintf('\n')
    x = xnew;
end
