function m=ddecestm(dfcn,er,options);
% DDECESTM  Estimates  m = (number of Chebyshev collocation points)  for soln of
%       a linear delay differential equation with multiple integer delays
%       and periodic coefficients.  Either takes one set of parameter values or 
%       samples to find worst case on grid in parameter space.  Uses 10^-6
%       as default tolerance or options.AbsTol otherwise.
%       Resulting  m  at least 6; warning if  m>100.
%
%    m=ddecestm(dfcn,eps0);
%       dfcn = handle of descriptor function to compute coeffs A(t,eps),
%              Bj(t,eps) and info L, n, tau, d
%          [NOTE: For j>=1,  dfcn(j,t,eps)  produces an n by n matrix 
%            value of coefficient B_j(t,eps).  If j=0 then it produces A(t,eps).
%            If j<0 then it produces a vector of information [L n tau d],
%            plus locations of kinks if appropriate.  See examples and
%            documentation.]
%       eps0  = particular parameter values; eps0 is 1 by d row vector
%
%    m=ddecestm(dfcn,er);
%    [As above except:]
%       er    = 1 by 2d row vector giving ranges of parameters
%
%    m=ddecestm(dfcn,eps0,options);
%    m=ddecestm(dfcn,er,options);
%    [As above but using:]
%       options.AbsTol: tolerance for Chebyshev polynomial interpolation
%              [positive scalar, {1e-6}]
%       options.Disp: display diagnostic information   [{'on'} | 'off']
%
%    See also DDECSPECT, DDECU, DDECIVP.

% (7/21/03 ELB)

if (nargin<2)|(nargin>3), error('needs 2 or 3 input arguments'), end
if nargin<3, options=ddecset('AbsTol',1.0e-6,'Disp','on'); end
   
info=feval(dfcn,-1,0,0); L=info(1); tau=info(3); d=info(4); % get info

% use eps0 or sample; sample at grid points in each parameter dimension
if length(er)==d,
   epslist=er;  NN=1;
else,
   if length(er)~=2*d, error('parameter range must be a length 2d row vect'), end
   % build list of parameter points from grid
   if d==1, % eps = [eps]
      NN=23; % number of grid points
      epslist=linspace(er(1),er(2),NN)';
   elseif d==2, % eps = [a b]
      en=7;
      al=linspace(er(1),er(2),en); bl=linspace(er(3),er(4),en);
      [a b]=meshgrid(al,bl);
      epslist=cat(3,a,b);
      NN=en^2;
      epslist=reshape(epslist,NN,2);
   elseif d==3, % eps = [a b c]
      en=7;
      al=linspace(er(1),er(2),en); bl=linspace(er(3),er(4),en); cl=linspace(er(5),er(6),en);
      [a b c]=meshgrid(al,bl,cl);
      epslist=cat(4,a,b,c);
      NN=en^3;
      epslist=reshape(epslist,NN,3);
      warning('DDECESTM:dequal3','d=3 case of reshaping not tested')
   else, error('d>3 not allowed'), end   
end

% estimate maximum eigenvalue of A for parameter values on grid
%    for sample of t values on interval of length T
maxeig=0;
if length(info)<=4 % no kinks
   
   for m=[5 10] % for tests of coeffs; m-1 relatively prime
      t = cos(pi*(0:m-1)/(m-1))';  t = (tau/2)*(t+1); % m colloc pts on [0 tau]
      for q=1:NN % go through pts on parameter grid
         for shift=0:tau:(L-1)*tau % look in each interval of length tau
            for s=1:m % look at each of m colloc pts
               A=feval(dfcn,0,t(s)+shift,epslist(q,:));
               maxeig=max(maxeig,max(abs(eig(A))));
            end;
         end    
      end
   end
   
else % kinks
   
   % KK = (# of actual kinks)+1 = number of intervals in which to divide [0,tau]
   % U is (L*m*n*KK) x (L*m*n*KK)
   KK=length(info)-4+1;
   kloc=info(5:3+KK);
   if max(kloc>tau)|max(kloc<0), error('kinks must be in interval [0,tau]'), end
   % kloc = locations of kinks including zero and tau; (KK+1) by 1 row vector
   kloc=[0 kloc tau];
   
   for m=[5 10] % for tests of coeffs; m-1 relatively prime
      t0 = cos(pi*(0:m-1)/(m-1))';
      shiftK=0;
      for kink=1:KK
         tauK=kloc(kink+1)-kloc(kink); 
         t=(tauK/2)*(t0+1)+shiftK;
         for q=1:NN % go through pts on parameter grid
            for shift=0:tau:(L-1)*tau % look in each interval of length tau
               for s=1:m % look at each of m colloc pts
                  A=feval(dfcn,0,t(s)+shift,epslist(q,:));
                  maxeig=max(maxeig,max(abs(eig(A))));
               end;
            end
         shiftK=shiftK+tauK;
         end
      end   
   end
end

tol=ddecget(options,'AbsTol',1.0e-6);
if strcmp(ddecget(options,'Disp','on'),'on')
   disp(['  DDECESTM: estimated max. spectral radius of A(t) is ' num2str(maxeig,'%5.3f')]),
   disp(['  DDECESTM: tolerance for determining  m  is ' num2str(tol,'%5.3e')]), end

r=maxeig*tau/4; cc=exp(maxeig*tau)*r^2; 
m=3;
while 1  % build upper bound in interpolation of e^(maxeig*t) formula
   cc=cc*r/m; 
   if cc < tol, break, else, m=m+1; end
end
if m>100, warning('DDECESTM:bigm','m exceeds 100'), end
m=max(m,6);

if strcmp(ddecget(options,'Disp','on'),'on')
   disp(['  DDECESTM: m=' num2str(m) ' Chebyshev collocation points']), end
