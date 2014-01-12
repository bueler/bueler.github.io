% BOOM  Script to show experimentally which (delta x, delta t) pairs
% produce instability.  The resulting plot shows the curve which
% separates stable and unstable cases.  We will see this curve is
%     delta t  <=  C  (delta x)^2,
% the stability criterion for the explicit scheme.  Requires 30 to 200
% seconds to run on various machines.
% Calls EXPLICITCHECK.

% we know that a dx=0.1 and dt=0.001 compuation was o.k.
% that is, try  explicit(10,100,0.1)  or  explicitcheck(10,100,0.1)
dx = 0.005:0.005:0.1;
dt = 0.00005:0.00005:0.001;

result = zeros(20,20);  % allocate space for zeros or ones
for j=1:20
  for k=1:20
    myJ = ceil(1 / dx(j));   % length of rod is 1
    myN = ceil(0.1 / dt(k)); % final time is 0.1
    result(j,k) = explicitcheck(myJ,myN,0.1);
  end
end;

surf(dt,dx,result)  % transposed relative to usual plotting convention;
                    % normal uses of "surf" are preceded by "meshgrid"
view(2), xlabel('dt'), ylabel('dx')
title('blue is stable, red is unstable')

