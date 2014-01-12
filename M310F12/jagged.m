function f = jagged(x,n,a,s)
%JAGGED Computes an approximation of a continuous nowhere 
%   differentiable function.
%   (By Douglas Arnold who happens to be at Penn. State U.)
%
% jagged(x,n,a,s) is      __
%                        \  | n     (s-2)m      m
%                         >        a       sin(a  x).
%                        /__| m=0
% In the limit as n->infinity this gives a continuous nowhere 
% differentiable function if a>1 and 1<s<2.  The case a=4, s=3/2 
% is (I think) the classical example of Weierstrass.  n=10 is a 
% reasonable value for graphical purposes.
%     A nice example for classroom purposes is
%  x = 0:2.e-5:1 ; y = jagged(x,10,4,1.2) ; plot(x,y)

f = zeros(size(x));
for m = n:-1:0 % loop backward to minimize round-off effects
  k = a^(n-m);
  f = f + a^((s-2)*(n-m)) * sin(k*x);
end

