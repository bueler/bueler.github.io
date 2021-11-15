% EXPAGERANK  Do P22 (b) and (EC).

disp('small example (|W|=5) in (b), (c), and (EC)')
% web as adjacency matrix
G = [0 0 1 0 0;  % a has link from c
     1 0 1 1 0;  % b has links from a,c,d
     1 1 0 0 1;  % c has links from a,b,e
     1 0 0 0 0;  % d has link from a
     0 0 0 1 0]; % e has link from d
[pr, A] = pagerank(G);
pr
% web as list of outlinks
W = { [2,3,4],
      [3],
      [1,2],
      [2,5],
      [3]     };
surfer(W,1000)
surfer(W,100000)


disp('big example (|W|=10) in (d)')
Wd = { [3], [1,3], [4,7], [5,7], [6,7], [7], [9], [2,3,7], [10], [8] };
format compact
Gd = formg(Wd)
[pagerank(Gd) surfer(Wd,1000) surfer(Wd,100000)]