function r = newton(f,df,x0)
% NEWTON Apply Newton's method to solve f(x)=0 using initial value x0.
% Inputs f(x) and df = f'(x) are functions.
% Example:
%   >> f = @(x) exp(x) - sqrt(4-x.^2)
%   >> df = @(x) exp(x) + (4-x.^2).^(-0.5) .* x
%   >> r = newton(f,df,1.0)

x = x0;
for j = 1:10
    if abs(f(x)) < 1.0e-14
      break
    end
    x = x - f(x) / df(x)
end
r = x;    
