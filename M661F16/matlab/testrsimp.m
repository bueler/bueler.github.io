% TESTRSIMP  A script to test my implementation of the "phase II" revised
% simplex method code (RSIMPII), based on Algorithm 13.1 in in Nocedal & Wright.
% Compares against the octave linear programming black box GLPK; see
%   https://www.gnu.org/software/octave/doc/v4.0.0/Linear-Programming.html

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if ~isOctave
    error('this test code only works in octave because it needs glpk')
end

for E = 1:6
    switch E
        case 1
            % Example 13.1 in Nocedal & Wright; book version has errors
            c = [-4 -2 0 0]';
            A = [1   1 1 0;
                 2 0.5 0 1];
            b = [5 8]';
            BB = [3 4];
        case 2
            % Example from wiki page for "revised simplex method":
            c = [-2 -3 -4 0 0]';
            A = [3 2 1 1 0;
                 2 5 3 0 1];
            b = [10 15]';
            BB = [4 5];
            % by hand:  x = [0 0 5 5 0]', lambda = [0 -4/3]'
        case 3
            % Example 5.2 on page 132 of Griva, Nash, and Sofer
            c = [-1 -2 0 0 0]';
            A = [-2 1 1 0 0;
                 -1 2 0 1 0;
                  1 0 0 0 1];
            b = [2 7 3]';
            BB = [3 4 5];
            % by hand:  x = [3 5 3 0 0]', lambda = [0 -1 -2]'
        case 4
            % Example 5.3 on page 134 of Griva, Nash, and Sofer; unbounded
            c = [-1 -2 0 0]';
            A = [-1 1 1 0;
                 -2 1 0 1];
            b = [2 1]';
            BB = [3 4];
        case 5
            % unbounded but origin is solution so succeeds
            c = [1 2 0 0]';
            A = [-1 1 1 0;
                 -2 1 0 1];
            b = [2 1]';
            BB = [3 4];
        case 6
            % Example from wiki page "Klee-Minty cube", in D=4 dimensions
            c = [-8 -4 -2 -1 0 0 0 0]';
            A = [ 1 0 0 0 1 0 0 0;
                  4 1 0 0 0 1 0 0;
                  8 4 1 0 0 0 1 0;
                 16 8 4 1 0 0 0 1];
            b = [5, 25, 125, 625]';
            BB = [5 6 7 8];
        otherwise
            error('invalid example case')
    end  % switch

    % run rsimpII:
    [x, f, lambda, k] = rsimpII(c, A, b, BB);
    % run black box:
    [xgl, fgl, status, extra] = glpk(c, A, b);

    % describe results
    fprintf('  case %d:  ',E)
    if all(isfinite(x)) & (status == 0)
        fprintf('%2d steps,  x within %.2e,  lambda within %.2e\n',...
                k, norm(x - xgl), norm(lambda - extra.lambda))
    else
        if status == 0
            fprintf('ERROR: RSIMPII reports unbounded but GLPK reports success!\n')
        else
            fprintf('RSIMPII reports unbounded; GLPK reports status = %d\n',status)
        end
    end
    fflush(stdout);
end

