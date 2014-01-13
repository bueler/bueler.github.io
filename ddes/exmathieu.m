function c=exmathieu(j,t,eps);
% EXMATHIEU  Produce coefficient matrices and info for 
%    delayed Mathieu equation:
%       d^2x/dt^2 + (delta+a cos(t)) x = b x(t-2 pi)
%    note eps=(delta,b), a=1  and B_0=A
%
% Stability chart example:
%      >> ddecspect(@exmathieu,[-1 5 -1.5 1.5]);
%      >> xlabel \delta, ylabel b
% IVP example:  
%    initial values x(t)=cos(t), dx/dt(t)=1+sin(2*t) for -2*pi <= t <= 0;
%    use delta=3.1, b=-0.5;  to find y(t) for 0 <= t <= 6*pi:
%      >> x=ddecivp(@exmathieu,[3.1 -0.5],inline('[cos(t);1+sin(2*t)]','t'),3);
% Eigenvalues example:
%      >> m=100;  eps0=[3.1 -0.5]; % stable point in plane
%      >> U=ddecU(@exmathieu,eps0,m);
%      >> eigtool(U)

% (7/21/03 ELB)

a=1.0;
if j<0,
   c=[1 2 2*pi 2]; % c=[L n tau d]
elseif j==0,
   c=[0 1; -( eps(1) + a*cos(t) ) 0];
elseif j==1,
   c=[0 0; eps(2) 0];
else, error('invalid j'), end

