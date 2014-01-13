function c=exscal(j,t,eps);
% EXSCAL  Produce coefficient matrices and info for 
%    first order scalar, one delay, constant coefficient DDE:
%       dx/dt = a x + b x(t-1)
%    note eps=(a,b)
%
% Stability chart example:
%      >> ddecspect(@exscal,[-1.5 1 -2.5 1]);
%      >> xlabel a, ylabel b
% IVP example:  to solve:   y'=y+y(t-1)
%    initial value y(t)=-t for -1 <= t <= 0;
%    to find y(t) for 0 <= t <= 2:
%      >> y=ddecivp(@exscal,[1 1],inline('-t'),2);
% Eigenvalues example:
%      >> m=20;  eps0=[0.0 -1.0];  % stable point in param plane
%      >> U=ddecU(@exscal,eps0,m);
%      >> eigtool(U)

if j<0,
   c=[1 1 1 2]; % c=[L n tau d]
elseif j==0,
   c=eps(1);
elseif j==1,
   c=eps(2);
else, error('invalid j'),end 
