% DETTABLE  Generate a somewhat clean table of values
% from DETERMINANT, with relative errors compared to
% the built-in DET.

for n=3:7
    A = magic(n);
    z = determinant(A);
    zexact = det(A);
    relerr = abs(z - zexact) / abs(zexact);
    fprintf('  %d: %12.3g %12.3g\n', n, z, relerr)
end
