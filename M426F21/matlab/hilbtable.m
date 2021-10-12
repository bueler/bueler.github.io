% HILBTABLE  Produce a table, and a figure, of *computed* condition
% numbers for some Hilbert matrices.  The computed condition numbers
% are inaccurate garbage once they reach 10^16 or so.

for n = 2:16
    A = hilb(n);
    kap = cond(A);
    fprintf('n = %2d:  A = hilb(%2d)  ==>  cond(A) = %.4e\n',...
            n, n, kap)
    semilogy(n, kap, 'bo'),  hold on
end
xlabel n,  ylabel('\kappa(A)')
