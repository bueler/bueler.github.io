function exer5newt(p)
% EXER5NEWT  special-purpose code!

alpha = log(2);        % yes, we know the exact answer

x = 1;                 % initial guess is somewhere near log(2)
f = @(x) 2 - exp(x);
df = @(x) - exp(x);
for n=1:4
  xnew = x - f(x) / df(x);
  Rn = abs(alpha - xnew) / (abs(alpha - x))^p
  x = xnew;
end
