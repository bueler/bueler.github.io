% TSP  Setup and solve traveling salesperson problem

label = ['A' 'F' 'J' 'N' 'S' 'W'];

edgew = [ -1 100 100 150 250 150;  % A
         100  -1 150 200 300 250;  % F
         100 150  -1  -1 200 200;  % J
         150 200  -1  -1  -1  -1;  % N
         250 300 200  -1  -1  -1;  % S
         150 250 200  -1  -1  -1]; % W

% generate permutations
notS = [1 2 3 4 6];   % not including Seattle
N = factorial(5);     % this many permutations of notS
p = [5*ones(N,1) perms(notS) 5*ones(N,1)];   % start and end in Seattle

% print one case on a single line
printcase = @(a, p, s) ...
    fprintf('%s  %c%c%c%c%c%c%c : %d\n', a, label(p(1)),label(p(2)),label(p(3)), ...
            label(p(4)),label(p(5)),label(p(6)),label(p(7)), s);

% evaluate cost of each (valid) permutation
mincost = 1.0e100;  % bigger than any
for j = 1:N
    % s gets -1 (invalid) or cost of path
    s = 0;
    for k = 1:6
        ce = edgew(p(j,k),p(j,k+1));
        if ce < 0
            s = -1;
            break
        else
            s = s + ce;
        end
    end
    % report valid case, and update optimal
    if (s > 0)
        printcase('feasible  ',p(j,:),s)
        if s < mincost
            minp = p(j,:);
            mincost = s;
        end
    end
end
printcase('optimal   ',minp,mincost)

