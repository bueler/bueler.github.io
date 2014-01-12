function z = sumfourthpowerFORLOOP(N)
% SUMFOURTHPOWER Compute
%    __ N      1
%    \       -----
%    /_ n=1   n^4
%    
% Example: >> sumfourthpowerFORLOOP(100)

z = 0;
for n = 1:N
  z = z + 1/n^4;
end
