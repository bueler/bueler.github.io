function [x, a, b, k] = hybrid(f,a,b,tol)
% HYBRID  Combine bisection and secant method into a hybrid method that
% maintains a bracket [a,b] (i.e. f(a), f(b) are opposite signs) while
% convering superlinearly like the secant method.
% Example:
%    >> f = @(x) x - cos(x);
%    >> x = hybrid(f,0.0,1.0,1e-6)
%    x =  0.73909
% Example including bracket and number of steps:
%    >> [x, a, b, k] = hybrid(f,0,2,1e-4)
%    x =  0.73908
%    a =  0.73873
%    b =  0.86274
%    k =  3
%    >> f(x), f(a), f(b)
%    ans =   -7.7297e-06
%    ans =   -5.8641e-04
%    ans =  0.21238

if f(a) * f(b) > 0
    error('[a,b] is not a bracket')
end
if abs(f(a)) < tol
    x = a;
    return
elseif abs(f(b)) < tol
    x = b;
    return
end

% do a step of bisection
[x0, a, b] = bistep(a, b);

% first computation of x1 and x
x1 = (a + b) / 2;
x = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));  % secant step

% each iteration recomputes a,b,x0,x1,x
for k = 1:20
    if abs(f(x)) < tol
        return
    elseif abs(f(x1)) < tol
        x = x1;
        return
    end
    if (x <= a) || (x >= b)   % is x outside (a,b)?
        % ignor x and do a step of bisection
        [x0, a, b] = bistep(a,b);
        if abs(f(x0)) < tol
            x = x0;
            return
        end
    elseif x == x1
        if abs(f(x)) >= tol
            error('unclear what happened')
        end
        return
    else
        if f(a) * f(x1) < 0              % is [a, x1] a bracket?
            if (x > a) && (x < x1)
                % we know a < x < x1
                if f(x) * f(x1) < 0      % is [x, x1] a bracket?
                    a = x;
                    b = x1;
                    x0 = x;
                else                     % is [a, x] a bracket?
                    b = x;
                    x0 = x;
                end
            else        % we know x1 < x < b; just do bisection on bracket
                [x0, a, b] = bistep(a,x1);
            end
        else                             % [x1, b] is a bracket
            if (x > x1) && (x < b)
                % we know x1 < x < b
                if f(x1) * f(x) < 0      % is [x1, x] a bracket?
                    a = x1;
                    b = x;
                    x0 = x;
                else                     % is [x, b] a bracket?
                    a = x;
                    x0 = x;
                end
            else        % we know a < x < x1; just do bisection on bracet
                [x0, a, b] = bistep(x1,b);
            end
        end
    end
    % again compute x1 and x
    if ~check(a,b,x0)
        [a b x0]
        error('check failed')
    end
    x1 = (a + b) / 2;
    x = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));  % secant step
end

    function [c, a, b] = bistep(a, b)
        % BISTEP  Do one step of bisection.  Returns c which is either a or b.
        % Return a,b which are a bracket.
        c = (a+b) / 2;
        if f(c) == 0
            x = c;
            return;
        end
        if f(c) * f(a) < 0
            b = c;
        else
            a = c;
        end
    end % function bistep

    function z = check(a,b,x0)
        % CHECK  Each iteration should recompute a,b,x0 so that a < b
        % and x0 is equal to either a or b.
        z = false;
        if a >= b
            return
        elseif (x0 == a) || (x0 == b)
            z = true;
        end
    end % function check

end % function hybrid
