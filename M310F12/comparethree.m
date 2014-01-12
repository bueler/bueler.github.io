function comparethree(N)
% COMPARETHREE compare three numerical ODE methods, namely Euler, midpoint,
% and Heun's, on two example problems
% problem 1:  y(0) = 0,  y' = 1 + y^2,  compute y(1.5)  [exact: y(1.5) = tan(1.5)]
% problem 2:  y(0) = 0,  y' = cos(ty) - 2*y,  compute y(1.5)  [exact unknown]

if nargin < 1, N = 5; end

tf = 1.5;
h = tf / N;
t = 0:h:tf;

for prob = 1:2
  if prob==1
    f = @(t,y) 1 + y.^2;
  else
    f = @(t,y) cos(t*y) - 2 * y;
  end
  
  yE = zeros(size(t));
  yM = yE;
  yH = yE;

  for k = 1:length(t)-1

    % Euler
    yE(k+1) = yE(k) + h * f(t(k),yE(k));

    % midpoint
    yhalf = yM(k) + (h/2) * f(t(k),yM(k));
    yM(k+1) = yM(k) + h * f(t(k)+h/2, yhalf);

    % Heun's
    ytilde = yH(k) + h * f(t(k),yH(k));
    yH(k+1) = yH(k) + h * (1/2) * ( f(t(k),yH(k)) + f(t(k+1),ytilde) );
  end
  
  % show table of numbers; just show last 5 rows
  if prob==1
    fprintf('last 5 rows of problem 1 results:  [Euler midpoint Heuns exact]\n')
    T = [yE' yM' yH' tan(t')];
  else
    fprintf('last 5 rows of problem 2 results:  [Euler midpoint Heuns]\n')
    T = [yE' yM' yH'];
  end
  T(end-5:end,:)
end

