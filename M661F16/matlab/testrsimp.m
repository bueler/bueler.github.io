% TESTRSIMP  a script to test my implementation of mu "phase II"
% revised simplex method code (RSIMPII) based on Algorithm 13.1 in
% in Nocedal & Wright

% Example from wiki page for "revised simplex method":
c = [-2 -3 -4 0 0]';
A = [3 2 1 1 0;
     2 5 3 0 1];
b = [10 15]';
BB = [4 5]';
% your code:
[x f lambda] = rsimpII(c, A, b, BB);
% black box:
[xmin, fmin, status, extra] = glpk(c, A, b);
norm(x - xmin)
abs(f - fmin)
norm(lambda - extra.lambda)

% Example 13.1 in Nocedal & Wright; I believe this results in the example are
% loaded with errors
c = [-4 -2 0 0]';
A = [1 1 1 0; 2 0.5 0 1];
b = [5 8]';
BB = [3 4]';
% your code:
[x f lambda] = rsimpII(c, A, b, BB);
% black box:
[xmin, fmin, status, extra] = glpk(c, A, b);
norm(x - xmin)
abs(f - fmin)
norm(lambda - extra.lambda)


