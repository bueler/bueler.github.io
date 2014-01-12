function z = myexp(x)
% MYEXP  Compute exp(x) to 15 digit accuracy by using only
% elementary operations (+,*,/).  Uses Chebyshev polynomial
% interpolation.  Example to compare:
%   >> myexp(56.7891),  exp(56.7891)

if x > 709,       z = Inf;    % overflow case
elseif x < -709,  z = 0;      % underflow case
else                          % reduce to  0 <= b < 1  case
  a = floor(x);  b = x - a;   % [a,b] = parts(x);
  % computes  z = exp(a)  where  a  is an integer
  e1 = 2.71828182845905;
  z = 1;
  for j=1:abs(a),  z = z * e1;   end
  if a < 0,  z = 1 / z;  end
  z = exp01(b) * z;
end

  function z = exp01(b)        %  exp01(b) = exp(b)  for  0 <= b < 1
  % x = 0.5 * (1 + cos((0:12)*pi/12));  % Chebyshev points
  % c = polyfit(x,exp(x),12)
  c = [5.24372447385248e-09,  1.03621292925589e-08,  3.09509325829247e-07,...
       2.70894679441688e-06,  2.48430832723558e-05,  1.98388293892942e-04,...
       1.38889843435922e-03,  8.33333089975084e-03,  4.16666670523784e-02,...
       1.66666666631979e-01,  5.00000000001453e-01,  9.99999999999986e-01,...
       1.00000000000000e+00];
  z = polyval(c,b);
  end

end
