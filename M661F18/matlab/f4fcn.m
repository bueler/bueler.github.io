function [f,df] = f4fcn(x)
% F4FCN  The objective function, and its gradient, for F4 on the Final Exam

f = 3.0 * sin(x(1)) + cos(x(2)) + 0.05 * (x(1)^2 - x(1)*x(2) + 2.0*x(2)^2);
if nargout > 1
    df = [3.0*cos(x(1)) + 0.05*(2.0*x(1)-x(2));
          -sin(x(2)) + 0.05*(-x(1)+4.0*x(2))];
end

