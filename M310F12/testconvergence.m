% TESTCONVERGENCE  tests the convergence of the estimates from TRAPSIMP
% as we make h smaller

zexact = quad(@(x) cos(x.^2),0,1,[1e-12 1e-12]);

fprintf('(trap err)/h^2   (simp err)/h^4\n')
fprintf('------------------------------\n')
for h = [0.5 0.2 0.1 0.05 0.02 0.01 0.005]
  n = round(1/h);
  [ztrap zsimp] = trapsimp(n);
  fprintf('  %12.10f     %12.10f\n',...
          abs(ztrap-z)/(h^2),abs(zsimp-z)/(h^4))
end
