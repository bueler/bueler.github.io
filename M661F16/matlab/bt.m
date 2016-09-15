function alphak = bt(xk,pk,f,dfxk, ...
                     alphabar,c,rho)
% BT  Use backtracking to compute fractional step length alphak.
%
% This is Algorithm 3.1 in Nocedal & Wright.  If successful, alphak satisfies
%    f(xk + alphak pk) <= f(xk) + c alphak df(xk)' * pk
% i.e. inequality (3.6a), the Armijo condition.  Stops if not descent direction.
%
% Usage:
%    alphak = bt(xk,pk,f,dfpk,
%                alphabar,c,rho)
% where the output is
%    alphak   fractional step length
% and the first 4 input arguments are required:
%    xk       column vector with current location
%    pk       column vector with current search direction
%    f        function handle (e.g. "f" if f is anonymous or @f if f is f.m)
%    dfxk     = (grad f)(xk)  column vector
% and the last three are optional:
%    alphabar defaults to 1.0
%    c        defaults to 1.0e-4
%    rho      defaults to 0.5
%
% Example 1:
%    >> f = @(x) (x.^2 + cos(x)).^2 - 10.0 * sin(5.0 * x);
%    >> df = @(x) 2.0 * (x.^2 + cos(x)) .* (2.0 * x - sin(x)) - 50.0 * cos(5.0 * x);
%    >> x = 0.0;  fx = f(x);  dfx = df(x);
%    >> p = - dfx / abs(dfx);      % steepest descent unit vector
%    >> alpha = bt(x,p,f,dfx)
%    >> x = x + alpha * p          % next step ... repeat steps as desired
%
% Example 2 ... see pits.m:
%    >> x = [1.5 0.5]';
%    >> [fx dfx Hfx] = pits(x);
%    >> p = Hfx \ (- dfx);         % Newton step vector
%    >> alpha = bt(x,p,@pits,dfx)
%    >> x = x + alpha * p          % next step ... repeat steps as desired

Dk = dfxk' * pk;
if Dk >= 0.0
    error('pk is not a descent direction ... stopping')
end

% set defaults according to which inputs are missing
if nargin < 6,  alphabar = 1.0;  end
if nargin < 7,  c = 1.0e-4;  end
if nargin < 8,  rho = 0.5;  end

% implement Algorithm 3.1
alphak = alphabar;
while f(xk + alphak * pk) > f(xk) + c * alphak * Dk
    alphak = rho * alphak;
end

