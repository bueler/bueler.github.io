function Z = sumstuff(N)
% SUMSTUFF Approximates infinite series
%    \sum_{n=1}^\infty cos(n) / n^3
% by computing the Nth partial sum.
% Example:
%   >> sumstuff(100)

nn = 1:N;
Z = sum(cos(nn) ./ nn.^3);
