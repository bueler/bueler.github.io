% HEATPIPE   Use Driscoll&Braun codes to solve
% a boundary-value problem for fluid temperature
% in a pipe with a localized heat source.
% Equation is
%   u'' - 3 u'(x) = r(x)
% where r(x) = - 20 e^(-30 (x-1.2)^2) is heating
% localized around x=1.2.  Boundary temperatures
% are u(0) = 0 and u(2) = 40.  Calls BVPLIN, which
% calls DIFFMAT2.  See Section 10.3.

% set up equation
L = 2;
xspan = [0,L];
p = @(x) -3*ones(size(x));    % steady flow to right
q = @(x) zeros(size(x));    % no "q u" term
r = @(x) - 200 * exp(-30 * (x-1.2).^2);
lval = 0;  rval = 40;

% plot heat source, i.e. -r(x)
xx = linspace(0,L,401);
figure(1),  plot(xx,-r(xx))
xlabel x,  ylabel('heating rate')

% solve for temperature
n = 30;     % adjust as desired
[x,u] = bvplin(p,q,r,xspan,lval,rval,n);
figure(2),  plot(x,u,'o:')
xlabel x,  ylabel('equilibrium temperature')
