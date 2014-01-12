% CLASS9DEC   commands shown in class on Monday 9 December for 
%             section 5.6

% show exact integral:
%    /3   -x/2
%    |   e     dx
%    /0
format long
exact = 2*(1-exp(-3/2))
format short

% n = 5 Trapezoid rule
n = 5
dx = (3 - 0)/n
x = 0:dx:3
y = exp(-x/2)
format long
% plot(x,y,'o')   <--- to view the points
trap5 = (dx/2) * ( y(1) + 2*sum(y(2:5)) +  y(6) )

% n = 500 Trapezoid rule, a bit more efficiently; gets 7 digit accuracy
n = 500;  dx = (3-0)/n;  x = 0:dx:3;  y = exp(-x/2);
trap500 = (dx/2) * ( y(1) + 2*sum(y(2:end-1)) +  y(end) )

% n = 4 Simpson's rule
n = 4;  dx = (3-0)/n;  x = 0:dx:3;  y = exp(-x/2);
simp4 = (dx/3) * ( y(1) + 4*y(2) + 2*y(3) + 4*y(4) +  y(5) )

% n = 50 Simpson's rule is more accurate than n = 500 Trapezoid rule
n = 50;  dx = (3-0)/n;  x = 0:dx:3;  y = exp(-x/2);
simp50 = (dx/3) * ( y(1) + 4 * sum(y(2:2:end-1)) + 2 * sum(y(3:2:end-2)) +  y(end) )

% n = 500 Simpson's rule gets 13 digit accuracy
n = 500;  dx = (3-0)/n;  x = 0:dx:3;  y = exp(-x/2);
simp500 = (dx/3) * ( y(1) + 4 * sum(y(2:2:end-1)) + 2 * sum(y(3:2:end-2)) +  y(end) )

% exact again, for comparison
exact
