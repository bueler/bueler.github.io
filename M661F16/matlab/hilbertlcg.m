% HILBERTLCG  Test LCG on Hilbert matrices of various sizes.

fprintf('  n:  iterations   residual norm\n')
for n = [5 8 12 20]
    A = hilb(n);  b = ones(n,1);  x0 = zeros(n,1);
    [x, xlist] = lcg(x0,A,b,1.0e-6,1000);
    fprintf(' %2d:         %3d        %.2e\n',...
            n, size(xlist,2), norm(A*x-b))
end
