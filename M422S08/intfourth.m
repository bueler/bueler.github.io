% compute integral
%
%    / infty     dx
%    |        ---------
%    / 0       1 + x^4
% 
% approximately by trapezoid rule

L = 1.0e3;  % actually integrate from 0 to L; f(L) < 10^-12
N = 1.0e5;  % number of subintervals

dx = L/N;
x=0:dx:L;
y = 1./(1+x.^4);
c=2.0*ones(size(x));  %coeffs in trapezoid rule 
c(1)=1; c(end)=1;
format long g

% graph with "plot(x,y)" or "semilogy(x,y)"

disp('trapezoid rule gives')
0.5*dx*sum(c*y')  % trap rule result: 1.11072073420626
disp('exact answer by contour integration was  pi/sqrt(8) =')
pi/sqrt(8)        % exact:            1.11072073453959

