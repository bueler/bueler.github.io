function c=excontrol(j,t,eps);
% EXCONTROL Produce coefficient matrices and info for
%    e'' + 2 xi e' + (alpha + 3 y^2) e = u
% where  u  is a control of the form
%    u = k1 e(t-tau) + k2 e'(t-tau)
% and
%    y^2 = 1/2 + 1/3 cos(2 pi t)
% and   tau = 1,  alpha = -1,  and  xi = .125  are fixed parameters.
% the stability chart parameters are k1, k2: eps = (k1,k2)
%
% Stability chart example (done in user desired style):
%      >> m=25; options=ddecset('DrawChart','off');
%      >> rho=ddecspect(@excontrol,[-0.7 1.5 -2 1],[80 80],m,options);
%      >> clevels=[.50 .60 .70 .80 .90 1 1.5 2];
%      >> [c,h] = contour(linspace(-0.7,1.5,80),linspace(-2,1,80),rho',clevels);
%      >> clabel(c,h), grid on, xlabel k_1, ylabel k_2
%      >> title('stability chart for control example; m=25')
% Eigenvalues example:
%      >> m=50;  eps0=[0.22 -0.25]; % most stable point from chart above
%      >> U=ddecU(@excontrol,eps0,m);
%      >> eigtool(U)

ysq=0.5+(1/3)*cos(2*pi*t);
if j<0,
   c=[1 2 1 2]; % c=[L n tau d]
elseif j==0,
   c=[0,          1        ;
      1.0-3*ysq,  -2*0.125 ];
elseif j==1,
   c=[0,       0;
      eps(1), eps(2)];
else, error('invalid j'), end
