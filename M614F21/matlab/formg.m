function G = formg(W)
% FORMG  Input W is a list of out-link destinations describing
% a web (a connected directed graph).  Output is the connectivity
% (adjacency) matrix of W.  Compare PAGERANK and SURFER.
% Example:
%   >> W = { [2,3,4], [3], [1,2], [2,5], [3]};
%   >> G = formg(W)
%   G =
%        0  0  1  0  0
%        1  0  1  1  0
%        1  1  0  0  1
%        1  0  0  0  0
%        0  0  0  1  0

n = length(W);
G = zeros(n,n);
for j = 1:n                  % go through columns of G
    G(W{j},j) = 1.0;
end
