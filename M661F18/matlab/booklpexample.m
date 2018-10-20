% BOOKLPEXAMPLE  Run MYSIMPLEX on the example in section 5.2, pages 132-133, of
% Griva, Nash, Sofer (2009).  Provides first minimal check on correctness.

c = [-1 -2]';
A = [-2 1; -1 2; 1 0];
b = [2 7 3]';
[x,z] = mysimplex(c,A,b,true)

