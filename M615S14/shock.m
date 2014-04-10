% SHOCK will be a code that demos upwind and flux-limited on Burger's eqn

% uses upwind scheme (4.56) from M&M:
%   Unew(j) = U(j) - (dt / (2 * dx)) * ( (1 - sgn(A_+)) (F(j+1) - F(j))
%                                       + (1 - sgn(A_-)) (F(j) - F(j+1)) )
% where by (4.52) we have F(j) = U(j)^2 / 2 and
%   A_+ = (F(j+1) - F(j)) / (U(j+1) - U(j))
%   A_- = (F(j) - F(j-1)) / (U(j) - U(j-1))


uinit = @(x) exp(-10 * (4 * x - 1).^2);

dx = 0.02;   % HUH?
x = 0:dx:1.0;
JJ = length(x)-1;

%[xx,tt] = meshgrid(x,x);
%uu = uinit(x0char(xx,tt));
%mesh(xx,tt,uu)

tf = [0.0 0.15 0.3];
t = 0.0;
ii = 1;
U = uinit(x);
while t < tf(end)
  if t >= tf(ii)
    plot(x,U,'ko-'),  hold on
    ii = ii + 1;
  end
  amax = max(U);
  dt = dx / amax;   % use nu = amax dt / dx = 1
  if t + dt > tf(ii)
    dt = tf(ii) - t;
  end
  nu = 0.5 * dt / dx;

  Unew = U;
  F = 0.5 * U.^2;
  for j = 2:JJ-1
    if U(j+1) == U(j)
      Aplus = U(j);
    else
      Aplus  = (F(j+1) - F(j)) / (U(j+1) - U(j));
    end
    if U(j) == U(j-1)
      Aminus = U(j);
    else
      Aminus = (F(j) - F(j-1)) / (U(j) - U(j-1));
    end
    tmp = (1 - sign(Aplus)) * (F(j+1) - F(j)) + (1 + sign(Aminus)) * (F(j) - F(j-1));
    Unew(j) = U(j) - nu * tmp;
  end
  % left endpoint: upwind if U<0 otherwise set to zero
  if U(1) >= 0.0
    Unew(1) = 0.0;
  else
    Unew(1) = U(1) - (U(1) * dt / dx) * (U(2) - U(1));
  end
  % right endpoint: upwind if U>=0 otherwise set to zero
  if U(JJ) >= 0.0
    Unew(JJ) = U(JJ) - (U(JJ) * dt / dx) * (U(JJ) - U(JJ-1));
  else
    Unew(JJ) = 0.0;
  end
  t = t + dt;
  U = Unew;
end
plot(x,U,'ko-'),  hold off

