function [z T64] = rombergmod(f,a,b)

% get trapezoid results for 1 2 4 8 16 32 64 subintervals
N = 6;
m = 2.^(0:N);            % 7 levels of refinement
T = zeros(size(m));
for j=1:length(m)
  T(j) = trap(f,a,b,m(j));  % redundant function evaluations in here
end
T64 = T(N+1)

% extrapolate to unreachable h=0 !!:
h = (b-a)./m;
p = polyfit(h.^2,T,N);   % extrapolate in h^2 versus T_n plane
z = p(end);              % evaluate constant term, the last poly coeff.

% uncomment to see the extrapolation
hsqf = 0:((b-a)/1000)^2:(b-a)^2;  % fine grid of h^2
plot(h.^2,T,'o',hsqf,polyval(polyfit(h.^2,T,N),hsqf))
xlabel('h^2'), ylabel('T(2^n)')

