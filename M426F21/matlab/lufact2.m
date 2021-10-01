function [L, U] = lufact2(A)
% LUFACT2  Factor A into L U where L is lower triangular and U is
% *unit* upper triangular.  Calls LUFACT.

[LL, UU] = lufact(A');
L = UU';
U = LL';
