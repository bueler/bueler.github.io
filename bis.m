function c = bis(a,b,f)
% BIS  Apply the bisection method to solve
%   f(x) = 0
% with initial bracket [a,b].  Example:
%   >> f = @(x) cos(x) - x      % define fcn
%   >> r = bis(0,1,f)           % find root
%   >> f(r)                     % confirm

if (feval(f,a)) * (feval(f,b)) > 0
  error('not a bracket!'), end
for k = 1:100
  c = (a+b)/2;
  r = feval(f,c);
  if abs(r) < 1e-12 
    return  % we are done
  elseif feval(f,a) * r >= 0.0 
    a = c;
  else
    b = c;
  end
end
error('no convergence')

