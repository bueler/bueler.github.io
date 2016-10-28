function cablebfgs(N)
% CABLEBFGS  Compare BFGS implementations on CABLE problem at high resolution.
% Requires: CABLE, BFGSNAIVE, BFGS

if nargin < 1
    N = 200;
end

f = @(u) cable(u,N,10);
u0 = -ones(N,1);

fprintf('running more efficient BFGS ...\n')
tic, [uk, uklist, alphaklist] = bfgsbt(u0,f,1.0e-8,1000); toc
fprintf('  ... %d steps\n',length(alphaklist))

fprintf('running original (naive) BFGS ...\n')
tic, [uk, uklist, alphaklist] = bfgsnaive(u0,f,1.0e-8,1000); toc
fprintf('  ... %d steps\n',length(alphaklist))

