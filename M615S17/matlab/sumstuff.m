function Z = sumstuff(N)
% SUMSTUFF approximates an infinite series

nn= 1:N;
Z = sum(cos(nn) ./ nn.^3);

