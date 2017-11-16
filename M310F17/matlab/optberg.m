function z = optberg(f,a,b,K)
% OPTBERG  Approximates the integral    /b
%                                       |   f(x) dx
%                                       /a
% by true, i.e. optimized, K-level Romberg integration.  Uses formulas (5.23)
% on page 308 and the formula on page 310 (both from Epperson, 2nd ed. 2013).
% Compare ROMBERG, which does the same computation inefficiently.

if nargin < 4, K = 5; end           % defaults to K=5, i.e. 2^5=32 points
R = zeros(K,K);                     % space for extrapolation (Romberg) table
n = 2;   h = (b-a) / n;
R(1,1) = h * (0.5 * f(a) + f(a+h) + 0.5 * f(b));  % = T_2(f)
for m = 2:K
    n = 2 * n;   h = (b-a) / n;
    x = a+h:2*h:b-h;                % midpoints relative to last T(f)
    R(m,1) = R(m-1,1)/2 + h * sum(f(x));  % = T_{2^m}(f);  see page 310
    for j = 1:m-1
        R(m,j+1) = (4^j * R(m,j) - R(m-1,j)) / (4^j - 1); % see (5.23)
    end
end
z = R(K,K);

