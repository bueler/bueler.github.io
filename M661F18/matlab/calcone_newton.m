% CALCONE_NEWTON  Find min of calculus I function by Newton's method
% to solve f'(x) = 0.

% f = @(x) (x.^2 + cos(x)).^2 - 10.0 * sin(5.0 * x);   % not actually used!
df = @(x) 2.0 * (x.^2 + cos(x)) .* (2.0 * x - sin(x)) ...
          - 50.0 * cos(5.0 * x);
ddf = @(x) 2.0 * (2.0 * x - sin(x)) .* (2.0 * x - sin(x)) ...
           + 2.0 * (x.^2 + cos(x)) .* (2.0 - cos(x)) ...
           + 250.0 * sin(5.0 * x);

x = 0.5           % initial estimate
for k = 1:5       % Newton's method ... 5 steps gives 16 digits
    x = x - df(x) / ddf(x)
end
