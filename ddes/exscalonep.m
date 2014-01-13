function c=exscalonep(j,t,eps);
% EXSCALONEP  Produce coefficient matrices and info for 
%    first order scalar, one delay, constant coefficient DDE:
%       dx/dt = -1.5 x + b x(t-1)
%    where b is only parameter.
%
% Stability chart example:
%      >> ddecspect(@exscalonep,[-3 3]);
%      >> xlabel b
% IVP example:  to solve:   y'=-1.5 y + b y(t-1)
%    initial value y(t)=-t for -1 <= t <= 0;
%    to find y(t) for 0 <= t <= 20 for b=1.48, b=1.52
%      >> y=ddecivp(@exscalonep,[1.48],inline('-t'),20);
%      >> y=ddecivp(@exscalonep,[1.52],inline('-t'),20);
% Eigenvalues example:
%      >> m=50; eps0=[1.52];  % barely unstable b
%      >> U=ddecU(@exscalonep,eps0,m);
%      >> eigtool(U)

a=-1.5;
if j<0,
   c=[1 1 1 1]; % c=[L n tau d]
elseif j==0,
   c=a;
elseif j==1,
   c=eps;
else, error('invalid j'),end 
