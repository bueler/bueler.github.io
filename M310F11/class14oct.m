% CLASS14OCT  Show how to do Newton's method at the command line.  Examples
% solve  sin(x) = 0  on [2,4]  and  x - cos(x) = 0  on [0,1].

% show first step of Newton
format long
x0 = 3
x1 = x0 - sin(x0) / cos(x0)

% restart, make it an iteration which updates x; we get 15 digits in 3 steps
x = 3
x = x - sin(x) / cos(x)
x = x - sin(x) / cos(x)
x = x - sin(x) / cos(x)
x = x - sin(x) / cos(x)  % no change at this step

% restart; show errors along the way
x = 3,  err = abs(x - pi)
x = x - sin(x) / cos(x),  err = abs(x - pi)
x = x - sin(x) / cos(x),  err = abs(x - pi)
x = x - sin(x) / cos(x),  err = abs(x - pi)

% new example: solve x - cos(x) = 0; use anonymous function syntax
f = @(x) x - cos(x)
df = @(x) 1 + sin(x)
f(2)       % test the functions: yes we can plug in numbers
df(2)
f(0),f(1)  % and we have a bracket, even though Newton's ignors the bracket

% run Newton; again it is really fast
x = 0.5
x = x - f(x) / df(x)
x = x - f(x) / df(x)
x = x - f(x) / df(x)
x = x - f(x) / df(x)
x = x - f(x) / df(x)  % no change at this step


