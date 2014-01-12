% REFINETRAP  Shrink the spacing h by factors of 2 to generate
% trapezoid rule results.

for part = 1:2
  % setup f(x) and [a,b]
  if part == 1
    fprintf('part (a)\n')
    f = @(x) 1./(1+25*x.^2);
    a = 0;  b = 1;
    exact = (1/5) * atan(5);             % so we can get errors
  else
    fprintf('part (c)\n')
    f = @(x) log(x);                     % = ln(x)
    a = 1;  b = 3;
    exact = 3 * log(3) - 2;
  end
  % run through the levels of refinement
  h = 0.5 * (b - a);
  for level = 1:7                        % note:  2^7 = 128
    x = a:h:b;
    y = f(x);
    c = ones(size(x));  c(2:end-1) = 2;  % c = [1 2 2 ... 2 1]
    Tn = 0.5 * h * sum(c * y');
    newerr = abs(Tn-exact);
    if level > 1
      fprintf('  h = %8f:  Tn = %8f,  error = %.2e  [shrunk by %6.3f]\n',...
              h,Tn,newerr,err/newerr)
    else
      fprintf('  h = %8f:  Tn = %8f,  error = %.2e\n',...
              h,Tn,newerr)
    end
    err = newerr;
    h = 0.5 * h;
  end
end
