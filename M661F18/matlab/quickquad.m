function [f,df,Hf] = quickquad(x)
% QUICKQUAD  Example used in testing POPDIP.

f = 0.5 * (x(1)-1)^2 + 0.5 * (x(2)+1)^2;
df = [x(1)-1;
      x(2)+1];
Hf = [1, 0;
      0, 1];

