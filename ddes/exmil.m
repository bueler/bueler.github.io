function M=exmil(j,t,eps);
% EXMIL is an info for Milling equation
% d^2x/dt^2 + c1 dx/dt + k1 x= -b h(t)/m [x(t)-x(t-tau)]
%
%Praveen Nindujarla 9/04
%chart:
% >> m=45;N=60; ddecspect('exmil',[0.2e4 2.5e4 0 5],[N N],m);


m1=2.573;   
%c1=5.888;k1=846436.8;             %units in rps
c1=5.888*60;k1=3047172481;                     %units in rpm   
if j<0,
   M=[1 2 1 2]; % M=[L n tau d]
elseif j==0,
    M=[0 1;(-k1/eps(1)^2)-eps(2)*h(t,eps(1))/(m1*eps(1)^2)      -c1/eps(1)];
    
elseif j==1,
    M=[0 0;eps(2)*h(t,eps(1))/(m1*eps(1)^2) 0];
else,error('invalid j'),end



function hht=h(t,Omega)
Omega1=1;                                      % delay is 1
Kt=5.5e8;   
Kn=2.0e8;
r=1;                                         % radial immersion ratio a/D=r
ang=2*pi;
N=1;                                           % N is the total number of teeth, for pth teeth
hht=0;
lwr_bnd=acos(2*r-1);                             % used for downmilling
% up_bnd=acos(1-2*r);                            % used for upmilling 
theta=ang*Omega1*t;               

for j=1:N
    phi_p=theta-(j-1)*(ang/N);
    m_2=mod(phi_p,ang);                         % in the interval [0,2pi)
    if (lwr_bnd<m_2) &(m_2<(1/2)*ang);         % condition for downmilling   
%     if (0<m_2) &(m_2<up_bnd);                   % condition for upmilling
        st=sin(phi_p);
        f=(Kt*cos(phi_p)+Kn*st)*st;
        hht=hht + f;
    end
end


    

