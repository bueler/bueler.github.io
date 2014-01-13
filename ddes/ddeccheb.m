function [t,D]=ddeccheb(tau,m);
% DDECHEB  Produces collocation points and the Chebyshev spectral 
%    differentiation matrix, normalized to the interval [0,tau].
%    A trivial modification of Trefethen's "cheb" in 
%    L. N. Trefethen, "Spectral Methods in MATLAB", SIAM Press 2000.
%
%    [t,D]=ddeccheb(tau,m);
%        tau = length of interval for collocation
%        m   = number of collocation points (= poly degree N plus one)
%        t   = m by 1 column vector of collocation points on [0,tau]
%        D   = spectral differentiation matrix
%
%    See also DDECIVP, DDECSPECT, DDECU.

% (7/21/03 ELB)

N=m-1;

% verbatim from Trefethen:
  if N==0, D=0; t=1; return, end
  x = cos(pi*(0:N)/N)'; 
  c = [2; ones(N-1,1); 2].*(-1).^(0:N)';
  X = repmat(x,1,N+1);
  dX = X-X';                  
  D  = (c*(1./c)')./(dX+(eye(N+1)));  % off-diagonal entries
  D  = D - diag(sum(D'));             % diagonal entries

% normalize
t=(tau/2)*(x+1);
D=(2/tau)*D;   
