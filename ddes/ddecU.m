function U=ddecU(dfcn,eps0,m,options);
% DDECU  Computes approximate solution operator U=U(eps_0) for
%       a linear delay differential equation with multiple integer delays
%       and piecewise smooth periodic coefficients.  Uses Chebyshev
%       collocation.
%
%    U=ddecU(dfcn,eps0);
%    [Uses ddecestm to determine  m = (number of Chebyshev collocation
%    points).]
%       dfcn  = handle of descriptor function to compute coeffs A(t,eps),
%               Bj(t,eps) and info L, n, tau, d
%          [NOTE: For j>=1,  dfcn(j,t,eps)  produces an n by n matrix 
%            value of coefficient B_j(t,eps).  If j=0 then it produces A(t,eps).
%            If j<0 then it produces a vector of information [L n tau d],
%            plus locations of kinks if appropriate.  See examples and
%            documentation.]
%       eps0  = particular parameter values; eps0 is 1 by d row vector
%       U     = solution (monodromy) matrix;  Lmn by Lmn matrix (if no
%               kinks);  
%
%    U=ddecU(dfcn,eps0,m);
%    [As above except:]
%       m     = number of Chebyshev collocation points (m>=3)
%
%    U=ddecU(fname,eps0,options);
%    U=ddecU(fname,eps0,m,options);
%    [As above but with further options:]
%       options.SpectRad: returns U=rho, the spectral radius
%           rho=max(abs(eig(U))) if 'on'   ['on' | {'off'}]
%       options.Disp: display diagnostic information   [{'on'} | 'off']
%       options.AbsTol: tolerance for Chebyshev polynomial interpolation;
%           see ddecestm   [positive scalar, {1e-6}]
%
%    See also DDECIVP, DDECSPECT, DDECESTM, DDECSET, DDECGET, EIGTOOL.
%    See example files, e.g. EXSCAL, EXMATHIEU, EXPIM.

% (8/4/03 ELB)


if (nargin>4)|(nargin<2), error('needs 2, 3, or 4 input arguments'), end
if nargin==4, getmflag=0;
else
   if nargin==2, getmflag=1; options=ddecset('SpectRad','off','Disp','on');
   elseif (nargin==3)&(isnumeric(m))&(~isstruct(m)),
      getmflag=0; options=ddecset('SpectRad','off','Disp','on');
   elseif isstruct(m), getmflag=1; options=m;
   else, error('third argument neither numeric nor a structure'); end
end

c=feval(dfcn,-1,0,0); 
if size(c,1)~=1, error('information c returned by descriptor function must be a row vector'), end
L=c(1); n=c(2); tau=c(3); % get info

if getmflag,
   m=ddecestm(dfcn,eps0,options);
end
if m<3, error('too few collocation points'), end
mn=m*n;
Lmn=L*mn; 

% KK = (# of actual kinks)+1 = number of intervals in which to divide [0,tau]
% U is (L*m*n*KK) x (L*m*n*KK)
KK=length(c)-4+1;
mnK=mn*KK; LmnK=Lmn*KK;

if KK==1 % no kinks
   
   % build collocation tools
   [t,D]=ddeccheb(tau,m);   D=kron(D,eye(n));
   D(mn-n+1:mn,:)=[zeros(n,mn-n) eye(n)];  % D is now DD^
   
   % MA(:,:,k) and MB(:,:,j,k) are mn x mn matrices:
   MA=zeros(mn,mn,L);  MB=zeros(mn,mn,L,L); 
   for k=1:L
      shift=(k-1)*tau;
      for s=1:m-1
         MA(n*(s-1)+1:n*s,n*(s-1)+1:n*s,k)=feval(dfcn,0,t(s)+shift,eps0);
         for j=1:L
            MB(n*(s-1)+1:n*s,n*(s-1)+1:n*s,j,k)=feval(dfcn,j,t(s)+shift,eps0);
         end;
      end;
      MB(mn-n+1:mn,1:n,1,k)=eye(n); % from connection equation
   end    
   
   R1=inv(D-MA(:,:,1));
   U=[zeros(Lmn-mn,mn) eye(Lmn-mn); zeros(mn,Lmn)];
   for j=1:L
      U(Lmn-mn+1:Lmn,Lmn-j*mn+1:Lmn-(j-1)*mn)=R1*MB(:,:,j,L+1-j);
      %  i-j = 1-j = L+1-j mod L when i=1
   end,
   for i=2:L
      Ri=inv(D-MA(:,:,i));
      Ui=[zeros(Lmn-mn,mn) eye(Lmn-mn); zeros(mn,Lmn)];
      for j=1:L
         imj=mod(i-j,L); if imj==0, imj=L; end,
         Ui(Lmn-mn+1:Lmn,Lmn-j*mn+1:Lmn-(j-1)*mn)=Ri*MB(:,:,j,imj);
      end,
      U=Ui*U;
   end
   
else % if kinks
   
   kloc=c(5:3+KK);
   if max(kloc>tau)|max(kloc<0), error('kinks must be in interval [0,tau]'), end
   % kloc = locations of kinks including zero and tau; (KK+1) by 1 row vector
   kloc=[0 kloc tau];
   if strcmp(ddecget(options,'Disp','on'),'on')
      disp(['  DDECU: ' num2str(KK-1) ' kink(s) inside [0 tau] (nonsmooth coeff locations)']), end
   
   % collocation tools
   [tcheb,Dcheb]=ddeccheb(2,m);  % get [-1,1] standard D
   Dcheb=kron(Dcheb,eye(n));
   DK=zeros(mnK,mnK);
   tK=zeros(m,KK);
   for kink=1:KK
      tauK=kloc(kink+1)-kloc(kink);
      D = (2/tauK)*Dcheb;
      D(mn-n+1:mn,:)=[zeros(n,mn-n) eye(n)];
      DK((kink-1)*mn+1:kink*mn,(kink-1)*mn+1:kink*mn) = D;
      tK(:,kink)=(tauK/2)*tcheb;
   end
   
   % MA(:,:,k) and MB(:,:,j,k) are mnK x mnK matrices:
   MA=zeros(mnK,mnK,L);  MB=zeros(mnK,mnK,L,L); 
   for k=1:L
      for kink=1:KK
         shift=(k-1)*tau+kloc(kink);
         for s=1:m-1
            kks=mn*(kink-1); % index for kink block
            tt=tK(s,kink)+shift; % t at which to evaluate coeffs
            if s==1, tt=tt-abs(tt)*10*eps; end % move left from kink by 10*(machine eps)
            MA(kks+n*(s-1)+1:kks+n*s,kks+n*(s-1)+1:kks+n*s,k)=feval(dfcn,0,tt,eps0);
            for j=1:L
               MB(kks+n*(s-1)+1:kks+n*s,kks+n*(s-1)+1:kks+n*s,j,k)=feval(dfcn,j,tt,eps0);
            end;
         end;
         if kink==1
            MB(mn-n+1:mn,1:n,1,k)=eye(n); % from connection equation
         else  % kink connection condition
            MA(mn*(kink-1)+(m-1)*n+1:mn*(kink-1)+(m-1)*n+n,mn*(kink-2)+1:mn*(kink-2)+n)=eye(n);
         end
      end
   end    
   
   R1=inv(DK-MA(:,:,1));
   U=[zeros(LmnK-mnK,mnK) eye(LmnK-mnK); zeros(mnK,LmnK)];
   for j=1:L
      U(LmnK-mnK+1:LmnK,LmnK-j*mnK+1:LmnK-(j-1)*mnK)=R1*MB(:,:,j,L+1-j);
      %  i-j = 1-j = L+1-j mod L when i=1
   end,
   for i=2:L
      Ri=inv(DK-MA(:,:,i));
      Ui=[zeros(LmnK-mnK,mnK) eye(LmnK-mnK); zeros(mnK,LmnK)];
      for j=1:L
         imj=mod(i-j,L); if imj==0, imj=L; end,
         Ui(LmnK-mnK+1:LmnK,LmnK-j*mnK+1:LmnK-(j-1)*mnK)=Ri*MB(:,:,j,imj);
      end,
      U=Ui*U;
   end
   
end % if kinks

if strcmp(ddecget(options,'Disp','on'),'on')
   disp(['  DDECU: U is ' num2str(LmnK) ' by ' num2str(LmnK) ' matrix']), end

if strcmp(ddecget(options,'SpectRad','off'),'on'), 
   U=max(abs(eig(U))); % fastest way because dense
end 
