% CABLEBFGS  Compare BFGS implementations on CABLE problem at high resolution.
% Requires: CABLE, BFGSNAIVE, BFGS

N=300;
f = @(u) cable(u,N,10);
u0 = -ones(N,1);

fprintf('running efficient BFGS ...\n')
tic, [uk, uklist, alphaklist] = bfgsbt(u0,f,1.0e-8,1000); toc
length(alphaklist)

fprintf('\nrunning naive BFGS ...\n')
tic, [uk, uklist, alphaklist] = bfgsnaive(u0,f,1.0e-8,1000); toc
length(alphaklist)

