function [f, J] = exns(x)
% EXNS  Input to NEWTONSYS = Function 4.5.1 in textbook.
% This function computes
%    f_1(x_1,x_2) = x_1^2 + x_2^2 - 4
%    f_2(x_1,x_2) = x_2 - e^{x_1}
% and its Jacobian.  The solution is where a circle crosses
% an exponential graph.
% Command line example:
%   >> x = newtonsys(@exns, [0.5; 1.5])

f = [x(1)^2 + x(2)^2 - 4;
     x(2) - exp(x(1))];
J = [2*x(1),      2*x(2);
     -exp(x(1)),  1];