function mycostest(tol)
% MYCOSTEST  Compare built-in COS with MYCOS.  Shows 1000 cases, "." for
% within tolerance and "X" for not.

for j=1:1000
    x = 100*randn();
    if abs(cos(x)-mycos(x)) > tol
        printf('X')
    else
        printf('.')
    end
end
printf('\n')

