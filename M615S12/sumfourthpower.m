function z = sumfourthpower(N)
% SUMFOURTHPOWER Compute
%    __ N      1
%    \       -----
%    /_ n=1   n^4
%    
% Example: >> sumfourthpower(100)

n = 1:N;
z = sum(1./n.^4);
