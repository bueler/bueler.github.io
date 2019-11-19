% COMPAREINT  Demonstrate four numerical integration rules on integral
%    /1
%    |   exp(-x^3+1)  dx
%    /-1
% The rules are:
%    trap = 5 point (composite) trapezoid
%    simp = 5 point (composite) Simpson's
%    cc   = 5 point Clenshaw-Curtis; uses Chebyshev points
%    gaus = 5 point Gauss rule; uses Legendre points

f = @(x) exp(-x.^3 + 1);
exact = 5.84271736760468;   % result of quad(f,-1,1) (and other sources)

% the nodes
xtrap = [-1 -0.5 0 0.5 1];
xsimp = xtrap;
xcc   = [-1 -1/sqrt(2) 0 1/sqrt(2) 1];
xgaus = [-0.9061798459386640 -0.5384693101056831 0.0000000000000000 ...
          0.5384693101056831 0.9061798459386640];

% the weights or coefficients
ctrap = [1/4 1/2 1/2 1/2 1/4];
csimp = [1/6 4/6 2/6 4/6 1/6];
ccc   = [1/15 8/15 12/15 8/15 1/15];
cgaus = [0.2369268850561891 0.4786286704993665 0.5688888888888889 ...
          0.4786286704993665 0.2369268850561891];

% apply the rules; all are of the form   sum_i c_i f(x_i)
trap = sum(ctrap .* f(xtrap));
simp = sum(csimp .* f(xsimp));
cc   = sum(ccc   .* f(xcc)  );
gaus = sum(cgaus .* f(xgaus));

% show results and errors
fprintf(' exact = %.15f\n',exact)
fprintf('  trap = %.15f   (error = %.3e)\n',trap,abs(trap-exact))
fprintf('  simp = %.15f   (error = %.3e)\n',simp,abs(simp-exact))
fprintf('  cc   = %.15f   (error = %.3e)\n',cc  ,abs(cc  -exact))
fprintf('  gaus = %.15f   (error = %.3e)\n',gaus,abs(gaus-exact))

