function ddecplotx(dfcn,w,m,loc,QQ);
% DDECPLOTX  Plots values of vector w representing x(t)
%    on an interval [loc*T,loc*T+QQ*T] where T=L*tau.
%
%    ddecplotx(dfcn,w,m,loc,QQ);
%       dfcn = handle of descriptor function to compute coeffs A(t,eps), Bj(t,eps)
%              and info L, n, tau, d
%           [Note: For j>=1, feval(dfcn,j,t,eps) produces n by n matrix 
%            value of coefficient B_j(t,eps).  If j=0 then it produces A(t,eps).
%            If j<0 then it produces a vector of information [L n tau d],
%            plus locations of discontinuities, if appropriate.  
%            See examples and documentation.]
%        w   = (QQ*L*m*n) by 1 column vector of values of x(t)
%        m   = number of collocation points in [0,tau]
%        loc = integer for location of first interval of length T: [loc*T,...]
%        QQ  = number of intervals of length T on which to plot
%
%    Example:
%     >> m=20;  w=ddeceval(@exmathieu,inline('[cos(t);1+sin(2*t)]','t'),m,0);
%     >> ddecplotx(@exmathieu,w,m,0,1);
%    See DDECIVP, DDECEVAL, EXMATHIEU.

% (8/6/03 ELB)

if nargin~=5, error('needs 5 input arguments'), end
if m<3, error('too few collocation points'), end
if QQ<1, error('needs to plot QQ>=1 intervals of length T'), end

c=feval(dfcn,-1,0,0); 
if length(c)>=4
   L=c(1); n=c(2); tau=c(3); % get info
   KK=length(c)-4+1;   
else, error('c too short'), end

figure, clf % new figure

t0 = cos(pi*(0:m-1)/(m-1))'; % m by 1; Cheb. colloc pts on [-1,1]

if KK==1 % no kinks
   
   t = (tau/2)*(t0+1); % normalize to [0,tau]
   % plot collocation points
   for i=1:QQ*L
      ww=reshape(w((i-1)*m*n+1:i*m*n),n,m);
      plot(t+(i-1)*tau+loc*L*tau,ww,'.','markersize',15); 
      hold on
   end
   % interpolate between collocation points using cubic splines
   tt=linspace(0,tau,101); 
   for i=1:QQ*L
      ww=reshape(w((i-1)*m*n+1:i*m*n),n,m);
      for k=1:n
         shift=(i-1)*tau+loc*L*tau;
         wp=interp1(t'+shift,ww(k,:),tt+shift,'spline');      
         plot(tt+shift,wp);
         hold on
      end
   end
   hold off
   
else % kinks
   
   % KK = (# of actual kinks)+1 = number of intervals in which to divide [0,tau]
   KK=length(c)-4+1;   
   kloc=c(5:3+KK);
   if max(kloc>tau)|max(kloc<0), error('kinks must be in interval [0,tau]'), end
   % kloc = locations of kinks including zero and tau; (KK+1) by 1 row vector
   kloc=[0 kloc tau];
   for i=1:QQ*L
      shiftK=0;
      for kink=1:KK
         tauK=kloc(kink+1)-kloc(kink); 
         t=(tauK/2)*(t0+1)+shiftK;
         % plot collocation points
         ww=reshape(w((i-1)*m*KK*n+(kink-1)*m*n+1:(i-1)*m*KK*n+kink*m*n),n,m);
         plot(t+(i-1)*tau+loc*L*tau,ww,'.','markersize',15); 
         hold on
         shiftK=shiftK+tauK;
      end
   end   

end

s=[]; for j=1:n, s=[s; ['x(t)_' num2str(j)]]; end
legend(s), xlabel t
