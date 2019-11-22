% TESTCONVERGENCE  tests the convergence of the estimates from TRAPSIMP
% as we make h smaller

zexact = quad(@(x) cos(x.^2),0,1,[1e-12 1e-12]);

fprintf('  h         (trap err)   (..)/h^2    (simp err)   (..)/h^4\n')
fprintf('  --------------------------------------------------------\n')
for n = [2 4 10 20 40 100 200 400]
  [ztrap zsimp] = trapsimp(n);
  h = 1/n;
  terr = abs(ztrap-zexact);
  serr = abs(zsimp-zexact);
  fprintf('  %6.4f    %9.4e   %8.6f    %9.4e   %8.6f\n',...
          h, terr, terr/(h^2), serr, serr/(h^4))
end
