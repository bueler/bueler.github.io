function x = ddecivp(dfcn,eps0,phi,Q,m,options);
% DDECIVP  Solve initial value problem for linear delay differential
%    equation with multiple integer delays and periodic coefficients
%    using Chebyshev collocation methods.
%
%    x = ddecivp(dfcn,eps0,ifcn,Q);
%    [Uses ddecestm to determine  m = (number of Chebyshev collocation
%    points).]
%       dfcn = handle of descriptor function to compute coeffs A(t,eps),
%              Bj(t,eps) and info L, n, tau, d
%          [NOTE: For j>=1,  dfcn(j,t,eps)  produces an n by n matrix 
%            value of coefficient B_j(t,eps).  If j=0 then it produces A(t,eps).
%            If j<0 then it produces a vector of information [L n tau d],
%            plus locations of kinks if appropriate.  See examples and
%            documentation.]
%       eps0  = particular parameter values
%       ifcn  = handle of initial (history) function evaluated on [-T,0]
%       Q     = number of intervals of length T on which to produce soln.
%       x     = solution on [0,Q*T]
%          [NOTE: x is a Q*L*m*n by 1 vector of values at collocation 
%           points.  ddecplotx is designed to plot such.]
%
%    x = ddecivp(dfcn,eps0,ifcn,Q,m);
%    [As above except:]
%       m     = number of Chebyshev collocation points (m>=3)
%
%    x = ddecivp(dfcn,eps0,phi,Q,m);
%    [As above except:]
%       phi   = values at collocation points of initial value 
%          [NOTE: phi is an L*m*n by 1 vector of values at collocation 
%           points on [-T=-L*tau,0].  ddeceval is designed to produce this.]
%
%    x = ddecivp(dfcn,eps0,phi,Q,options);
%    x = ddecivp(dfcn,eps0,phi,Q,m,options);
%    [As above but with further options:]
%       options.DrawSoln: plot solution in new window [{'on'} | 'off']
%       options.Disp: display diagnostic information [{'on'} | 'off']
%       options.AbsTol: tolerance for Chebyshev polynomial interpolation;
%           see ddecestm   [positive scalar, {1e-6}]
%
%    See also DDECESTM, DDECEVAL, DDECPLOTX, DDECSPECT, DDECU.
%    See example files, e.g. EXSCAL, EXMATHIEU, EXPIM.
%    For more general DDE initial value problems, see DDE23.

% (8/4/03 ELB)

if (nargin<4)|(nargin>6), error('needs 4, 5, or 6 input arguments'), end
if nargin==6, getmflag=false;
else
   if nargin==4, getmflag=true; options=ddecset('DrawSoln','on','Disp','on');
   elseif (nargin==5)&(isnumeric(m))&(~isstruct(m)),
      getmflag=false; options=ddecset('DrawSoln','on','Disp','on');
   elseif isstruct(m), getmflag=true; options=m;
   else, error('fifth argument neither numeric nor a structure'); end
end

if getmflag,
   m=ddecestm(dfcn,eps0,options);
end
if m<3, error('too few collocation points'), end
if Q<1, error('needs to produce Q>=1 intervals of solution'), end

c=feval(dfcn,-1,0,0); 
if length(c)>=4
   L=c(1); n=c(2); tau=c(3); % get info
   KK=length(c)-4+1;   
else, error('c too short'), end

% convert initial function handle to a vector
if isa(phi,'function_handle')|isa(phi,'inline')
   realphi=ddeceval(dfcn,phi,m,-1);
   if strcmp(ddecget(options,'Disp','on'),'on')
      disp(['  DDECIVP: initial (history) function evaluated on interval [' num2str(-L*tau) ',0]']), end
else
   if size(phi)~=[L*m*n 1], error('values phi of initial function of wrong size'), end
   realphi=phi;
end

% For now, use DDECU.  (See more efficient method, in case of large Q, in notes.)
U=ddecU(dfcn,eps0,m,options);

xx=zeros(L*m*n*KK,Q);
xx(:,1)=U*realphi;
%fprintf('  .')
for q=2:Q
   xx(:,q)=U*xx(:,q-1);
%   fprintf('.')
end
%fprintf('\n')
x=reshape(xx,Q*L*m*n*KK,1);

if strcmp(ddecget(options,'Disp','on'),'on')
   disp(['  DDECIVP: solution computed on interval [0,' num2str(Q*L*tau) ']']), end

if strcmp(ddecget(options,'DrawSoln','on'),'on'), 
   ddecplotx(dfcn,[realphi; x],m,-1,Q+1);
end 
