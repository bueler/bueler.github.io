% BIGKAPPA  Find a random 2 x 2 matrix with big condition
% number and apply VISMAT to it.

N = 1000;
for j = 1:N
    A = randn(2,2);
    if cond(A) > 100
        fprintf('found A with kappa(A) = %.2f > 100 ...\n', cond(A))
        break
    end
end
fprintf('viewing A using VISMAT ...\n')
vismat(A)
