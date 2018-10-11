function [z, xk, xklist] = sdquad(x0,Q,c,tol)
% SDQUAD  Steepest-descent optimization for quadratic functions
% Usage:  [z, xk, xklist] = sdquad(x0,Q,c,tol)

maxiters = 20000;                % never take more steps than this
c = c(:);  xk = x0(:);           % force into column shape
if nargout > 2                   % start keeping track of iterates
    xklist = [xk];               %     if user wants that
end
for k = 1:maxiters
    fxk = 0.5 * xk' * Q * xk - c' * xk;
    dfxk = Q * xk - c;
    if norm(dfxk) < tol          % absolute tolerance on gradient f
        break
    end
    pk = - dfxk;                 % steepest descent
    alpha = - dfxk' * pk / (pk' * Q * pk);
    xk = xk + alpha * pk;        % overwrites old point
    if nargout > 2
        xklist = [xklist xk];    % append latest point to list
    end
end
z = fxk;

