% EXER622  Do Exercise 6.2.2 from Driscoll & Braun.

fcount = 0;
for part = ['b', 'g']
    if part == 'b'
        f = @(t,u) u + t;  b = 1;  u0 = 2;
        uexact = @(t) - 1 - t + 3*exp(t);
    elseif part == 'g'
        f = @(t,u) 2 * (1 + t) .* (1 + u.^2);  b = 0.5;  u0 = 0;
        uexact = @(t) tan(2*t + t.^2);
    else,  error('how did I get here?'),  end

    % first figure shows the solution
    [t, u] = eulerivp(f, [0,b], u0, 320);
    fcount = fcount + 1;  figure(fcount)
    plot(t,u),  xlabel t,  ylabel u,  axis tight
    title(sprintf('part (%s): solution',part))

    % second figure shows errors for n=40,80,...,10240
    n = 10 * 2.^(1:10);
    for k = 2:10
        [t, u] = eulerivp(f, [0,b], u0, n(k));
        err(k) = abs(u(end) - uexact(b));
    end
    fcount = fcount + 1;  figure(fcount)
    loglog(n(2:10),err(2:10),'o-', n(2:10),10*n(2:10).^(-1),'r--')
    xlabel n,  axis tight,  legend('errors','1st order')
    title(sprintf('part (%s): errors at final time',part))
end
