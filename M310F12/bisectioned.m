function c = bisectioned(f,a,b,tol)
% BISECTIONED  Ed's bisection code.  Call it like this:
%   c = bisectioned(f,a,b,tol)
% where
%   f   = continuous function for which we want to compute the root
%   a,b = initial bracket; checks if f(a)*f(b) <= 0 and fails if not
%   tol = stop when bracket is smaller than this number
%   c   = center of final bracket, an estimate of the root
% Note: This code cannot check that f is continuous!  Do that yourself.
% Example to compute sqrt(7).  Use 'format long' to see lots of digits:
%   >> f = @(x) x.^2 - 7
%   >> bisectioned(f,1,3,1e-6)

if a > b,  error('bad initial bracket [a,b] with a>b'),  end
fa = f(a);  fb = f(b);
if f(a)*f(b) > 0,  error('bad initial bracket with f(a)f(b) > 0'),  end

c = (a+b)/2;
while (b - a) > 2 * tol
  fc = f(c);
  if fc * fa >= 0
    a  = c;  fa = fc;
  else
    b  = c;  fb = fc;
  end
  %fprintf('  [a,b] = [%12.8f,%12.8f]\n',a,b)
  c = (a+b)/2;
end
