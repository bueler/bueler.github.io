function z = deg4int(f,a,b)
% DEG4INT Approximates the integral of f(t) on [a,b] using 4th-degree
% polynomial interpolation.
% Examples:
%     >> deg4int(@(x) sin(x),0,pi)  % exact = 2
%     >> deg4int(@(t) t.^4,-1,2)    % exact = 33/4 = 6.6

x = linspace(a,b,5);
y = f(x);

c = polyfit(x,y,4);   % polynomial:  c(1)*t^4 + c(2)*t^3 + ... + c(5)
% alternative to polyfit:
%    A = vander(x);
%    c = (A \ y')';

g = c ./ (5:-1:1);
z = b*polyval(g,b) - a*polyval(g,a);
% alternative for calculating z:
%    z = (c(1)/5)*(b^5-a^5) + (c(2)/4)*(b^4-a^4) + ...
%        (c(3)/3)*(b^3-a^3) + (c(4)/2)*(b^2-a^2) + c(5)*(b-a);

