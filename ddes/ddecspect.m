function rho=ddecspect(dfcn,er,en,m,options);
% DDECSPECT  Computes spectral radii in parameter space for
%    a linear delay differential equation with multiple integer delays
%    and periodic coefficients.  Displays stability chart.
%
%    rho=ddecspect(dfcn,er);
%       dfcn = handle of descriptor function to compute coeffs A(t,eps), Bj(t,eps)
%              and info L, n, tau, d
%           [Note: For j>=1, feval(dfcn,j,t,eps) produces n by n matrix 
%            value of coefficient B_j(t,eps).  If j=0 then it produces A(t,eps).
%            If j<0 then it produces a vector of information [L n tau d],
%            plus locations of kinks, if appropriate.  
%            See examples and documentation.]
%       er    = 1 by 2d row vector giving ranges of parameters
%       rho   = (d=1,2,3) dimensional array of spectral radii of 
%               the solution matrix U for the DDE
%       [Uses ddecestm with  TOL=10^-5 to determine  m = (number of Chebyshev 
%        collocation points).  Produces stability chart with 40 by 40 points.]
%
%    rho=ddecspect(dfcn,er,en);
%    [As above except:]
%       en    = 1 by d row vec of number of grid points in parameter space
%
%    rho=ddecspect(dfcn,er,en,m);
%    [As above except:]
%       m     = number of Chebyshev collocation points (m>=3)
%
%    rho=ddecspect(dfcn,er,en,m,options);
%    [As above but with further options:]
%       options.DrawChart: display chart [{'on'} | 'off']
%       options.Disp: display diagnostic information [{'on'} | 'off']
%
%    See also DDECIVP, DDECU, DDECESTM, DDECSET, DDECGET.
%    See example files, e.g. EXSCAL, EXMATHIEU.

% (7/21/03 ELB)

if (nargin>5)|(nargin<2), error('needs 2, 3, 4, or 5 input arguments'), end
if nargin<5, options=ddecset('DrawChart','on','Disp','on'); end
if nargin<4,
   m=ddecestm(dfcn,er);
   if strcmp(ddecget(options,'Disp','on'),'on'),
      disp(['  DDECSPECT: Using  m = ' num2str(m) ' Chebyshev collocation points.'])
   end
end
if m<3, error('too few collocation points'), end

c=feval(dfcn,-1,0,0); L=c(1); n=c(2); tau=c(3); d=c(4); % get info
if nargin<3, 
   defaulten=40;
   en=defaulten*ones(1,d);  
   if strcmp(ddecget(options,'Disp','on'),'on'),
      disp(['  DDECSPECT: Using  en = ' num2str(defaulten) ' parameter points in each dimension.'])
   end
end

if length(er)~=2*d, error('parameter range must be a length 2d row vect'), end
if length(en)~=d, error('number of parameter points not a length d row vect'), end

% build collocation tools
[t,D]=ddeccheb(tau,m);  D=kron(D,eye(n));
mn=m*n;
D(mn-n+1:mn,:)=[zeros(n,mn-n) eye(n)];  % this is DD^

% for each point in parameter space, determine spectral radius
tic
if d==1, % eps = [eps]
   epslist=linspace(er(1),er(2),en(1));
   rho=zeros(en(1),1);
   for i=1:en(1)
      rho(i)=getrho(L,dfcn,n,tau,m,epslist(i),t,D);
      if (i==20)&strcmp(ddecget(options,'Disp','on'),'on')
         disp(['  DDECSPECT: Estimated time for spectral radii/chart = ' num2str(toc*en(1)/20) ' seconds.'])
      end
   end,
elseif d==2, % eps = [a b]
   alist=linspace(er(1),er(2),en(1)); blist=linspace(er(3),er(4),en(2));
   rho=zeros(en(1),en(2));
   for ia=1:en(1), for ib=1:en(2)
      rho(ia,ib)=getrho(L,dfcn,n,tau,m,[alist(ia) blist(ib)],t,D);
      if (((ia-1)*en(2)+ib)==100)&strcmp(ddecget(options,'Disp','on'),'on')
         disp(['  DDECSPECT: Estimated time for spectral radii/chart = ' num2str(toc*en(1)*en(2)/100) ' seconds.'])
      end
   end, end
elseif d==3, % eps = [a b c]
   al=linspace(er(1),er(2),en(1)); bl=linspace(er(3),er(4),en(2));
      cl=linspace(er(5),er(6),en(3));
   rho=zeros(en(1),en(2),en(3));
   for ia=1:en(1), for ib=1:en(2), for ic=1:en(3)
      rho(ia,ib,ic)=getrho(L,dfcn,n,tau,m,[al(ia) bl(ib) cl(ic)],t,D);
      if (((ia-1)*en(2)*en(3)+(ib-1)*en(3)+ic)==200)&strcmp(ddecget(options,'Disp','on'),'on')
         disp(['  DDECSPECT: Estimated time for spectral radii/chart = ' num2str(toc*en(1)*en(2)*en(3)/200) ' seconds.'])
      end
   end, end, end
else, error('only produces stability diagrams in 1,2,3 dimensions'), end

if strcmp(ddecget(options,'DrawChart','on'),'on'),
   ddecchart(rho,er);
   title(['DDECSPECT stability chart. m = ' num2str(m) ' Cheb colloc pts.']);
end
if strcmp(ddecget(options,'Disp','on'),'on'),
   disp(['  DDECSPECT: Actual time = ' num2str(toc) ' seconds.'])
end


%%%%%%%%%%%%%%

function rho=getrho(L,dfcn,n,tau,m,eps,t,D);

if L==1,  % for efficiency, use simple form here
   mn=m*n;
   MA=zeros(mn); MB=MA;
   for s=1:m-1
      MA(n*(s-1)+1:n*s,n*(s-1)+1:n*s)=feval(dfcn,0,t(s),eps);
      MB(n*(s-1)+1:n*s,n*(s-1)+1:n*s)=feval(dfcn,1,t(s),eps);
   end;
   MB(mn-n+1:mn,1:n)=eye(n); % from connection equation
   rho=max(abs(eig(inv(D-MA)*MB)));
   
else
   mn=m*n;  Lmn=L*mn;  U=zeros(Lmn);
   % MA(:,:,k) and MB(:,:,j,k) are mn x mn matrices:
   MA=zeros(mn,mn,L);  MB=zeros(mn,mn,L,L); 
   for k=1:L
      shift=(k-1)*tau;
      for s=1:m-1
         MA(n*(s-1)+1:n*s,n*(s-1)+1:n*s,k)=feval(dfcn,0,t(s)+shift,eps);
         for j=1:L
            MB(n*(s-1)+1:n*s,n*(s-1)+1:n*s,j,k)=feval(dfcn,j,t(s)+shift,eps);
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
      Ui=[zeros(Lmn-mn,mn) eye(Lmn-mn); zeros(mn,Lmn)];
      Ri=inv(D-MA(:,:,i));
      for j=1:L
         imj=mod(i-j,L); if imj==0, imj=L; end,
         Ui(Lmn-mn+1:Lmn,Lmn-j*mn+1:Lmn-(j-1)*mn)=Ri*MB(:,:,j,imj);
      end,
      U=Ui*U;
   end
   
   rho=max(abs(eig(U))); % FASTER THAN WITH eigs BECAUSE GENERALLY DENSE (I THINK)
   
end
