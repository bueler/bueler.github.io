% EXERCISE2P2N3  Call FINITEDIFF to get absolute errors for parts (a), (b), (c).

format short e
hlist = [1/4, 1/8, 1/16, 1/32];

fprintf(' h  :    from (2.1)  from (2.5)\n')

fprintf('part (a)\n')
z = 1 / (2*sqrt(2));    % exact f'(x)
for h = hlist
    [z1, z2] = finitediff(@(x) sqrt(x+1),1,h);
    fprintf('1/%2d:    %.2e    %.2e\n',1/h,abs(z1-z),abs(z2-z))
end

fprintf('part (b)\n')
z = 1 / 2;    % exact f'(x)
for h = hlist
    [z1, z2] = finitediff(@(x) atan(x),1,h);
    fprintf('1/%2d:    %.2e    %.2e\n',1/h,abs(z1-z),abs(z2-z))
end

fprintf('part (c)\n')
z = - pi;    % exact f'(x)
for h = hlist
    [z1, z2] = finitediff(@(x) sin(pi * x),1,h);
    fprintf('1/%2d:    %.2e    %.2e\n',1/h,abs(z1-z),abs(z2-z))
end
