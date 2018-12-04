function [f,df,Hf] = glacierfcn(u)
% GLACIERFCN  Evaluate objective function, gradient, and Hessian for glacier
% viscous/climate energy function.

N = 21;         % hard-wired for now
mu = 1.0e-14;
L = 100.0e3;    % 100 km

x = linspace(-L,L,N);

%y = zeros(size(x));
%for j = 1:length(y)
%    y(j) = mclimate(x(j));
%end
%plot(x/1000.0,31556926.0*y)

dx = 2 * L / (N-1);

FIXME

f = 0;
df = 0;
Hf = 0;
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

