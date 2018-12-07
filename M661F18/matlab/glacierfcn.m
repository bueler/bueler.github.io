function [f,df,Hf] = glacierfcn(u)
% GLACIERFCN  Evaluate objective function, gradient, and Hessian for glacier
% viscous/climate energy function.  The continuum objective is a functional
%          /L
%   f[u] = |   (mu/4) (u'(x))^4 - m(x) u(x) dx
%          /-L
% Uses midpoint rule.

u = u(:);
n = length(u);
u = [0; u; 0];  % length n+2

L = 100.0e3;    % 100 km
x = linspace(-L,L,n+2);

% objective f(u)
mu = 1.0e-14;
dx = 2 * L / (n+1);
f = 0;
for j = 1:n+1
    xmid = 0.5 * (x(j) + x(j+1));
    dudx = (u(j+1) - u(j))/dx;
    uav = 0.5 * (u(j) + u(j+1));
    f = f + (mu / 4) * dudx^4 - mclimate(xmid) * uav;
end
f = f * dx;

% gradient grad f(u)
df = zeros(n,1);
for k = 1:n
    j = k+1;
    dudxl = (u(j) - u(j-1))/dx;
    dudxr = (u(j+1) - u(j))/dx;
    xmidl = 0.5 * (x(j-1) + x(j));
    xmidr = 0.5 * (x(j) + x(j+1));
    df(k) = - mu * (dudxr^3 - dudxl^3) ...
            - 0.5 * (mclimate(xmidl) + mclimate(xmidr));
end

% gradient grad f(u)
Hf = zeros(n,n);
C = 3.0 * mu / dx;
for k = 1:n
    j = k+1;
    dudxl = (u(j) - u(j-1))/dx;
    dudxr = (u(j+1) - u(j))/dx;
    Hf(k,k) = C * (dudxl^2 + dudxr^2);
    if k > 1
        Hf(k,k-1) = - C * dudxl^2;
    end
    if k < n
        Hf(k,k+1) = - C * dudxr^2;
    end
end

end % function glacierfcn

    function m = mclimate(x)
    % MCLIMATE  Evaluate contrived mass balance for glacier.
    spera = 31556926.0;  % seconds per year
    x = x / 1.0e3;       % x in km
    if x <= -70.0
        m = -3.0;
    elseif x < 20.0
        m = -3.0 + (6.0/90.0) * (x + 70.0);
    elseif x < 70.0
        m = 3.0 - (6.0/50.0) * (x - 20.0);
    else
        m = -3.0;
    end
    m = m / spera;
    end % function mclimate

