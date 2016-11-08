% TESTRSIMP  

% Example from wiki page for "revised simplex method":
c = [-2 -3 -4 0 0]';
A = [3 2 1 1 0;
     2 5 3 0 1];
b = [10 15]';
BB = [4 5]';
[x f lambda] = rsimpII(c, A, b, BB)

% Example 13.1 in Nocedal & Wright:
%c = [-4 -2 0 0]';
%A = [1 1 1 0; 2 0.5 0 1];
%b = [5 8]';
%BB = [3 4]';
%[x f lambda] = rsimpII(c, A, b, BB)


