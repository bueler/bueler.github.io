function mycostest(tol)
% MYCOSTEST  Compare built-in COS with MYCOS.  Shows 500 cases, "." for
% within tolerance, i.e. |mycos(x)-cos(x)|<tol, and "X" for not.
% Example:
%   >> mycostest(1.0e-6)
%   >> mycostest(1.0e-8)

for k = 1:10
    for j = 1:50
        x = 100*randn();
        if abs(cos(x)-mycos(x)) > tol
            fprintf('X')
        else
            fprintf('.')
        end
    end
    fprintf('\n')
end
