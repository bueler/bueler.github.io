function [z h] = beam(cspace)
% BEAM Solve tent pole optimization problem by approximation and brute force.
% The height of the pole is represented by a list of N=5 coefficients in a
% Fourier sine series,
%   h(x) = c1 sin(x) + c2 sin(2 x) + c3 sin(3 x) + c4 sin(4 x) + c5 sin(5 x)
% Grid of coefficients c_j, with spacing cspace, in five dimensions, is
% searched.  Does integral exactly.
%
% Example run:
%   >> [z h] = beam(0.05)
%   >> plotbeam(h)
% WARNING: Several minutes run time!  This case checks 2.9 million
% = 41*41*21*9*9 points.  It runs at least 5 times faster if 0.05 --> 0.1.

N = 5;
bounds = [0.9 1.1;
          1.2 1.4;
          0.4 0.6];

z = 1.0e100;
h = zeros(1,N);
for c1 = 0.0:cspace:2.0
    for c2 = -1.0:cspace:1.0
        fprintf('.')
        for c3 = -0.5:cspace:0.5
            for c4 = -0.2:cspace:0.2
                for c5 = -0.2:cspace:0.2
                    htest = [c1 c2 c3 c4 c5];
                    h1 = evalh(htest,1);
                    p1 = (h1 >= bounds(1,1)) & (h1 <= bounds(1,2));
                    if p1
                        h2 = evalh(htest,2);
                        p2 = (h2 >= bounds(2,1)) & (h2 <= bounds(2,2));
                        if p2
                            h3 = evalh(htest,3);
                            p3 = (h3 >= bounds(3,1)) & (h3 <= bounds(3,2));
                            if p3
                                fval = f(htest);
                                if fval < z
                                    z = fval;
                                    h = htest;
                                    fprintf('*')
                                else
                                    fprintf('o')
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
fprintf('\n')

    function z = evalh(h,x)
        k = 1:N;
        z = h * sin(k * x)';
    end

    function z = f(h)
        k = 1:N;
        z = (pi/4.0) * k.^4 * (h.^2)';
    end
end

