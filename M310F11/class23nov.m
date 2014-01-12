% CLASS23NOV  Steps in building Romberg integration.
% Uses problem
%    /10
%    |   cos(x) dx = sin(10)
%    / 0
% See also:  romberg.m,  trap.m,   fastromberg.m

format long

disp('with 64 subintervals on finest level:')
H = 10-0;
h = H * 2.^(-(0:6));          % spacing for 7 levels of trapezoid rule
t = zeros(1,7);
for n = 1:7
  hh = h(n);
  x = 0:hh:10;
  t(n) = (hh/2) * [1 2*ones(1,2^(n-1)-1) 1] * cos(x)';
end
% wrong way:
%p = polyfit(h,t,6);           % do extrapolation
%p(end)                        % get constant term
p = polyfit(h.^2,t,6);        % do extrapolation in h^2 vs T_n plane
p(end)                        % get constant term
sin(10)

figure(1)
plot(h.^2,t,'o','markersize',14),  grid on
xlabel('h^2'),  ylabel('trapezoid estimate  T_n')
title('Romberg integration extrapolates to h^2=0 with this data')

disp('with 128 subintervals on finest level:')
% redo: finer last level
h = H * 2.^(-(0:7));
t = zeros(1,8);
for n = 1:8
  hh = h(n);
  x = 0:hh:10;
  t(n) = (hh/2) * [1 2*ones(1,2^(n-1)-1) 1] * cos(x)';
end
p = polyfit(h.^2,t,7); p(end)   % get constant term
[t'; p(end); sin(10)]           % table: trapezoid then Romberg then exact

