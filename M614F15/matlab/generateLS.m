function [A, b] = generateLS(k);
% GENERATELS  Ggenerate one of two linear systems.
% Usage:
%   >> [A b] = generateLS(k);

if k == 1
    A = [2 1 0; 0 2 1; 1 0 3];
    b = [2 1 4]';
elseif k == 2
    A = [1 2 3 0; 2 1 -2 -3; -1 1 1 0; 0 1 1 -1];
    b = [7 1 1 3]';
else
    error("only cases k=1,2 available")
end
