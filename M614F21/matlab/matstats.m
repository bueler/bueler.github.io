% MATSTATS  Compute and plot functions of random matrices.

N = 10;           % number of tries
S = 8;            % maximum size is m = 2^S
mm = 2.^(1:S);    % yes, this works!

% compute values
for k = 1:S
    m = mm(k);
    for n = 1:N
        A = 20.0 * rand(m,m) - 10.0;
        ranks(k, n) = rank(A);
        if ranks(k, n) ~= m
            fprintf('WARNING:  rank(A) is *not* m')
        end
        norms(k, n) = norm(A);
        absdets(k, n) = abs(det(A));
        if absdets(k, n) > 1.0e308
            fprintf('WARNING:  |det(A)| overflow for m=%d\n', m)
        end
    end
end

% make plots
figure(1),  loglog(mm, norms, 'ko', 'markersize', 12)
xlabel('m'),  ylabel('norm(A)'),  axis([1, 512, 1, 1000])
xticks(mm),  xticklabels({'2','4','8','16','32','64','128','256'})
print('a1p2norms.pdf')
figure(2),  loglog(mm, absdets, 'ko', 'markersize', 12)
xlabel('m'),  ylabel('|det(A)|'),  axis([1, 512, 1.0, 1.0e308])
xticks(mm),  xticklabels({'2','4','8','16','32','64','128','256'})
yticks(10.0.^(0:50:300))
print('a1p2dets.pdf')
