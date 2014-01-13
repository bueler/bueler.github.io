function w = ddeceval(dfcn,xfcn,m,loc);
% DDECEVAL  Evaluate R^n (or C^n) valued function of time t at Chebyshev 
%    L*m collocation points in an interval of length T where T=L*tau.
%    For use in evaluating initial condition, choose loc=-1.
%
%    w = ddeceval(dfcn,xfcn,m,loc);
%       dfcn  = handle of descriptor function to compute coeffs A(t,eps),
%               Bj(t,eps) and info L, n, tau, d
%          [NOTE: For j>=1,  dfcn(j,t,eps)  produces an n by n matrix 
%            value of coefficient B_j(t,eps).  If j=0 then it produces A(t,eps).
%            If j<0 then it produces a vector of information [L n tau d],
%            plus locations of kinks if appropriate.  See examples and
%            documentation.]
%       xfcn = handle of function x(t)
%       m    = number of collocation points in [0,tau]
%       loc  = location of interval of length T: [loc*T,(loc+1)*T]
%       w    = (L*m*n) by 1 column vector of values of x(t)
%
%    Example:
%       >> w=ddeceval(@exmathieu,inline('[cos(t); 1+sin(2*t)]','t'),6,0)
%    gives L*m*n=1*6*2=12 by 1 vector w of values of xex(t).  
%    To plot resulting function:
%       >> ddecplotx(@exmathieu,w,6,0,1)
%    See  DDECIVP, DDECPLOTX, EXMATHIEU.

% (8/4/03 ELB)

if nargin~=4, error('needs 4 input arguments'), end
if m<3, error('too few collocation points'), end

c=feval(dfcn,-1,0,0); L=c(1); n=c(2); tau=c(3); % get info
locT = loc*L*tau;

if length(c)==4
   
   t = cos(pi*(0:m-1)/(m-1))'; % m by 1; Cheb. colloc pts on [-1,1]
   t = (tau/2)*(t+1); % normalize to [0,tau]
   w=[];
   for i=1:L
      v=[];
      for k=1:m      % build v which is m*n by 1
         v((k-1)*n+1:k*n,1)=feval(xfcn,t(k)+(i-1)*tau+locT); 
      end
      w=[w;v];
   end
   
elseif length(c)>4 % kinks
   
   % KK = (# of actual kinks)+1 = number of intervals in which to divide [0,tau]
   KK=length(c)-4+1;   
   kloc=c(5:3+KK);
   if max(kloc>tau)|max(kloc<0), error('kinks must be in interval [0,tau]'), end
   % kloc = locations of kinks including zero and tau; (KK+1) by 1 row vector
   kloc=[0 kloc tau];
   
   t0 = cos(pi*(0:m-1)/(m-1))';
   w=[];
   for i=1:L
      shiftK=0;
      for kink=1:KK
         tauK=kloc(kink+1)-kloc(kink); 
         t=(tauK/2)*(t0+1)+shiftK;
         v=[];
         for k=1:m % look at each of m colloc pts
            v((k-1)*n+1:k*n,1)=feval(xfcn,t(k)+(i-1)*tau+locT); 
         end;
         w=[w; v];
         shiftK=shiftK+tauK;
      end   
   end
      
else, error('c too short'), end
