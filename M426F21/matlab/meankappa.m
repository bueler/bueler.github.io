% MEANKAPPA  Compute the average value of the condition number of
% random 2 x 2 matrices.  In particular, we find r so that on
% average,  cond(kappa(A)) = 10^r  when  A = randn(2,2).

for N = [1000 1.0e4 1.0e5]
    r = 0.0;
    for j = 1:N
        A = randn(2,2);
        r = r + log10(cond(A));
    end
    r = r / N;   % = average of log10(kappa(A))
    fprintf('N = %6d:  average kappa(A) = %.3f = 10^{%.3f}\n',...
            N, 10.0^r, r)
end
