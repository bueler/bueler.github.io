function pr = surfer(W,m)
% SURFER  Random-surfer version of PageRank computation.
% Input W is a list of out-link destinations.  Does m steps of
% Markov chain using RAND.  Compare PAGERANK.  Example:
%   >> W = { [2,3,4], [3], [1,2], [2,5], [3]};
%   >> surfer(W,1000)
%   >> surfer(W,100000)

p = 0.85;                    % 1-p is probability of random jump
n = length(W);
pr = zeros(n,1);
s = ceil(n*rand(1));         % start from random location
for k = 1:m
    z = rand(1);             % z uniform on [0,1]
    if (z > p)               % random jump (including to start)
        z = (z-p)/(1-p);     % z uniform on [0,1] again
        s = ceil(n*z);       % j randomly from {1,...,n}
    else
        z = z / p;           % z uniform on [0,1] again
        k = ceil(length(W{s})*z);  % use links
        s = W{s}(k);         % j randomly from W{s}
    end
    pr(s) = pr(s) + 1;       % record current
end
pr = pr / sum(pr);           % normalize
