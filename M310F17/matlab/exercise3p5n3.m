% EXERCISE3P5N3  Do exercise 3 in section 3.5.

xn = [10.0;
       5.25;
       3.1011904761905;
       2.3567372726442;
       2.2391572227372;
       2.2360701085329;
       2.2360679775008;
       2.2360679774998];
alpha = xn(8);                   % Matlab indices start at 1; this is x_7

% compute  (alpha - x_n+1) / (alpha - x_n)^2  for all appropriate indices:
(alpha - xn(2:7)) ./ (alpha - xn(1:6)).^2
