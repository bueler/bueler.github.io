% REDEXAMPLES  Use reduced Newton to solve quadratic optimization with
% linear constraints.  Solves three examples based on EASY2DQUAD, EASY5DQUAD.
% See REDNEWTONBT for method.  All solved in just one iteration.

% Example 1:
%     min  f(x) = 5 x1^2 + (1/2) x2^2                                n = 2
%     s.t. x1 - 2 x2 = 3                                             m = 1
xexact = [3/41, -10/41];   % found by hand
A = [1 -2];
b = [3];
x0 = [3; 0];    % feasible initial iterate
[xk, xklist] = rednewtonbt(x0,@easy2dquad,A,b,1.0e-8);
xklist

% Example 2:  unconstrained
%     min  f(x) = 5 x1^2 + (1/2) x2^2                                n = 2
%                                                                    m = 0
xexact = [0, 0];   % found by hand
x0 = [-1; 5];
[xk, xklist] = rednewtonbt(x0,@easy2dquad,[],[],1.0e-8);
xklist

% Example 3:
%     min  f(x) = 10 x1^2 + 5 x2^2 + x3^2 + 0.5 x4^2 + 0.1 x5^2      n = 5
%     s.t. x1 - x2 + x3 = 1                                          m = 2
%               x4 - x4 = 0
xexact = [1/13,-2/13,10/13,0,0];   % found by hand
A = [1 -1 1 0  0;
     0  0 0 1 -1];
b = [1; 0];
x0 = [2 0 -1 3 3]';    % feasible initial iterate
[xk, xklist] = rednewtonbt(x0,@easy5dquad,A,b,1.0e-8);
xklist

