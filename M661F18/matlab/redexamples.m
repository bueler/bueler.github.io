function redexamples(tol)
% REDEXAMPLES  Use reduced Newton to solve nonlinear optimization problems with
% linear constraints.  Solves four examples.  Three use EASY2DQUAD, EASY5DQUAD.
% See REDNEWTONBT for method.

if nargin < 1,  tol = 1.0e-8;  end

% Example 1:  quadratic
%     min  f(x) = 5 x1^2 + (1/2) x2^2                                n = 2
%     s.t. x1 - 2 x2 = 3                                             m = 1
xexact = [3/41, -60/41]';   % found by hand
A = [1 -2];
b = [3];
x0 = [3; 0];    % feasible initial iterate
[xk, xklist] = rednewtonbt(x0,@easy2dquad,A,b,tol);
xklist'
norm(xexact-xk)

% Example 2:  quadratic, unconstrained
%     min  f(x) = 5 x1^2 + (1/2) x2^2                                n = 2
%                                                                    m = 0
xexact = [0, 0]';   % found by hand
x0 = [-1; 5];
[xk, xklist] = rednewtonbt(x0,@easy2dquad,[],[],tol);  % empty constraint
xklist'
norm(xexact-xk)

% Example 3:  quadratic
%     min  f(x) = 10 x1^2 + 5 x2^2 + x3^2 + 0.5 x4^2 + 0.1 x5^2      n = 5
%     s.t. x1 - x2 + x3 = 1                                          m = 2
%               x4 - x4 = 0
xexact = [1/13,-2/13,10/13,0,0]';   % found by hand
A = [1 -1 1 0  0;
     0  0 0 1 -1];
b = [1; 0];
x0 = [2 0 -1 3 3]';    % feasible initial iterate
[xk, xklist] = rednewtonbt(x0,@easy5dquad,A,b,tol);
xklist'
norm(xexact-xk)

% Example 4:  quartic
%     min  f(x) = x1^4 - x2                                          n = 2
%     s.t. x1 + x2 = 2                                               m = 1
xexact = [-4^(-1/3), 2+4^(-1/3)]';   % found by hand
A = [1 1];
b = [2];
x0 = [1; 1];    % feasible initial iterate
[xk, xklist] = rednewtonbt(x0,@easyquartic,A,b,tol);
xklist'
norm(xexact-xk)
end % function redexamples

    function [f, df, Hf] = easyquartic(x)
    f = x(1)^4 - x(2);
    df = [4*x(1)^3; -1];
    Hf = [12*x(1)^2, 0;
          0,         0];
    end % function easyquartic

