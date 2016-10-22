function xklist = conjdir(x0,A,b,P)
% CONJDIR  The "conjugate directions" method described in section 5.1 of
% Nocedal & Wright.  Computes
%   x_{k+1} = xk + alphak pk
% for pk equal to the columns of P, which are *assumed* to be conjugate.
% Note alphak = - rk' * pk / (pk' * A * pk), the result of exact minimization
% of  f(x) = (1/2) x' * A * x - b' * x  in the direction pk; here
% rk = A * xk - b is the residual at xk.
%
% WARNING: This is not a practical algorithm, but instead a step toward
% LCG = linear conjugate gradients.
%
% Example:
%   >> A = [2 1; 1 1];  b = [0 0]';
%   >> P = [1 1; 0 -2];       % by-hand calc constructs conjugate columns
%   >> P(:,1)' * A * P(:,2)   % check it ... gives zero
%   >> x0 = [3 3]';
%   >> xk = conjdir(x0,A,b,P)  % gives x2 = 0
%
% See also: CONJDIRVIS

% do a bunch of size checking
x0 = x0(:);  % force into column
n = length(x0);
if any(size(A) ~= [n n]), error('A is not n x n'), end
b = b(:);    % force into column
if length(b) ~= n, error('b is not length n'), end
if size(P,1) ~= n, error('columns of P are not length n'), end

% run the conjugate directions method
xk = x0;
xklist = xk;
for k = 1:size(P,2)
    pk = P(:,k);
    rk = A * xk - b;
    alphak = - rk' * pk / (pk' * (A * pk));
    xk = xk + alphak * pk;
    xklist = [xklist xk];
end

