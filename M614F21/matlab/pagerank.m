function [pr, A] = pagerank(G)
% PAGERANK  Compute PageRank as described in P22
% on Assignment #9, from the connectivity (adjacency) matrix
% of a web, i.e. a connected directed graph.  Example:
%   >> G = [0 0 1 0 0;  % a has link from c
%           1 0 1 1 0;  % b has links from a,c,d
%           1 1 0 0 1;  % c has links from a,b,e
%           1 0 0 0 0;  % d has link from a
%           0 0 0 1 0]; % e has link from d
%   >> pagerank(G)

% input check
n = size(G,1);
assert (n == size(G,2))         % G is square
assert (all(all(G .* G == G)))  % every entry of G is 0,1
assert (sum(diag(G)) == 0)      % no self-links

% generate transition-probability matrix
p = 0.85;
c = sum(G);       % column sum gives out-degree of each node
delta = (1-p)/n;
for j = 1:n
    A(:,j) = p * G(:,j) / c(j) + delta;
end

% get eigenvector for eigenvalue which is very close to 1
[X, D] = eig(A);
assert (max(abs(diag(D))) < 1 + 100*eps)  % check all |lambda| < 1
j = find(abs(diag(D) - 1) < 100*eps);
pr = real(X(:,j));
pr = pr / sum(pr);