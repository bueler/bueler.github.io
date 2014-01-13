function c=exturn(j,t,eps);
% EXTURN  Produce coefficient matrices for turning model
%     ddx + 2 zeta omega dx + omega^2 x = k1/m (x(t-tau)-x)
%    where tau=60/Omega, omega=sqrt(k/m), zeta=c/(2 m omega);
%       m=50 kg,   omega=775 rad/s,   zeta=0.05.
%    Note eps=(Omega,k1) in units (krpm,N/(10^(-6) m)).
%
% Stability chart example:
%      >> ddecspect(@exturn,[2000 10000 0 20]);
%      >> xlabel('turning rate \Omega in rpm')
%      >> ylabel('cutting coefficient k_1 in N/\mu m')

% (2/9/05 ELB)

m=50.0; % kg
zeta=0.05; % no units
omega=775; % rad/s

if j<0,
   c=[1 2 1 2]; % c=[L n tau d]
elseif j==0,
   tau=60/eps(1);
   k1=eps(2)*1.0e6;
   c=[0                            1;
       -(omega^2 + k1/m)*tau^2   -2*zeta*omega*tau];
elseif j==1,
   tau=60/eps(1);
   k1=eps(2)*1.0e6;
   c=[0             0; 
      (k1/m)*tau^2  0];
else, error('invalid j'), end

