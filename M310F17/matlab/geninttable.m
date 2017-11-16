% GENINTTABLE  Generate a table of numerical integration results.
% Uses GAUSS4, TRAPOL, and ROMBERG.

f = @(x) x .* exp(-x);
exact = 1 - 3 * exp(-2);
fprintf(' exact = %.12f\n',exact)

G = gauss4(f,0,2);
fprintf('gauss4 = %.12f  has error = %.2e\n',G,abs(G-exact))
for K = 2:5
    n = 2^K;
    T = trapol(f,0,2,2^K);
    R = romberg(f,0,2,K);
    fprintf('  T_%2d = %.12f  has error = %.2e\n',n,T,abs(T-exact))
    fprintf('  R_%2d = %.12f  has error = %.2e\n',n,R,abs(R-exact))
end

