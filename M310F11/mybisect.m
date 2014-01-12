function c = mybisect(f,a,b,tol)
% MYBISECT  Do bisection on input function and bracket. Achieve
% desired error tolerance.  Function f must be a continuous.
% Interval [a,b] must satisfy f(a)*f(b) < 0.
% Example:  To solve  sin(x)=0  on the interval [2,4] to 12 digits
% of accuracy:
%   >> f = @(x) sin(x)
%   >> mybisect(f,2,4,1e-12)

if f(a)*f(b) >= 0, error('MYBISECT requires a bracket'), end

n = ceil((log(b-a) - log(tol)) / log(2));
fprintf('  [doing n = %d steps for error < %.2e]\n',n,tol)

for j=1:n
  c = (a+b) / 2;
  if f(a)*f(c) < 0
    % leave a alone
    b = c;  % update b
  elseif f(b)*f(c) < 0
    a = c;  % update a
    % leave b alone
  else
    return  % c is the answer because f(c) = 0
  end % if
end % for

