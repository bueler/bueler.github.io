function [x,y] = coastline(N)
% COASTLINE  Generate a random coastline by N levels.  For example:
%   >> [x,y] = coastline(3);
%   >> plot(x,y),  axis off,  axis equal

y = [0.0 0.0];
for j = 1:N
    ynew = zeros(1,2*length(y)-1);
    for k = 1:length(y)
        ynew(2*k-1) = y(k);
    end
    for i = 2:2:length(ynew)-1
        ynew(i) = (ynew(i-1) + ynew(i+1))/2;
        if rand(1) > 0.5
            coin = 1.0;
        else
            coin = -1.0;
        end
        ynew(i) = ynew(i) + coin / 4^j;
    end
    y = ynew;
end
x = 0.0:1/2^N:1.0;

