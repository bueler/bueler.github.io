% TESTRSIMP  A script to test my implementation of the "phase II" revised
% simplex method code (RSIMPII), based on Algorithm 13.1 in in Nocedal & Wright.
% Compares against the octave linear programming black box GLPK; see
%   https://www.gnu.org/software/octave/doc/v4.0.0/Linear-Programming.html

for K = 1:3
    switch K
        case 1
            % Example 13.1 in Nocedal & Wright; book version has errors
            c = [-4 -2 0 0]';
            A = [1   1 1 0;
                 2 0.5 0 1];
            b = [5 8]';
            BB = [3 4]';
        case 2
            % Example from wiki page for "revised simplex method":
            c = [-2 -3 -4 0 0]';
            A = [3 2 1 1 0;
                 2 5 3 0 1];
            b = [10 15]';
            BB = [4 5]';
            % by hand:  x = [0 0 5 5 0]', lambda = [0 -4/3]'
        case 3
            % Example 5.2 on page 132 of Griva, Nash, and Sofer
            c = [-1 -2 0 0 0]';
            A = [-2 1 1 0 0;
                 -1 2 0 1 0;
                  1 0 0 0 1];
            b = [2 7 3]';
            BB = [3 4 5]';
            % by hand:  x = [3 5 3 0 0]', lambda = [0 -1 -2]'
        otherwise
            error('invalid example case')
    end  % switch
    % run rsimpII:
    [x, f, lambda] = rsimpII(c, A, b, BB);
    % run black box:
    [xgl, fgl, status, extra] = glpk(c, A, b);
    fprintf('    case %d:  x within %.2e,  lambda within %.2e\n',...
            K, norm(x - xgl), norm(lambda - extra.lambda))
end

