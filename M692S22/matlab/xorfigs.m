function xorfigs
% XORFIGS  Generate figures for a 2-layer neural net that computes XOR.

X = [0 0;
     0 1;
     1 0;
     1 1];
Y = [0 1 1 0]';

% the net; activations are ReLU in 2nd layer, identity in 3rd
W = [1 1; 1 1];                 % NOT invertible
c = [0 -1];
w3 = [1; -2];

subplot(2,2,1)
figfig(Y,X)
title('problem: XOR')
subplot(2,2,2)
figfig(Y,X*W)
title('XW: crush onto line')
subplot(2,2,3)
figfig(Y,X*W+c)                 % implicit expansion: "+c" for each row
title('XW+c: shift line downward')
subplot(2,2,4)
figfig(Y,max(0,X*W+c))
title('max(0,XW+c): linearly separable')

    function figfig(Y,Z)
        for j=1:4
            if Y(j) == 0
                plot(Z(j,1),Z(j,2),'bo','markersize',12)
            else
                plot(Z(j,1),Z(j,2),'r*','markersize',12)
            end
            hold on
        end
    end % function

end % function

