function exer7sect6p4(part)
% EXER7SECT6P4  Do part c or d of Exercise 7 in section 6.4 of Epperson 2nd ed.
% Shows error tables from trapezoid rule predictor-corrector method PREDCORR.
% Examples:    >> exer7sect6p4('c')      % or 'd'

% special to this problem
t0 = 0.0;   tf = 1.0;   levels = 10;
if part == 'c'
    f = @(t,y) 1 - 4*y;
    yexact = @(t) 0.25 * (3*exp(-4*t) + 1);
    y0 = 1.0;
elseif part == 'd'
    f = @(t,y) - y .* log(y);
    yexact = @(t) exp(log(3)*exp(-t));
    y0 = 3.0;
else,  error('unknown part'),  end
% uncomment to plot:   ttt = 0:.01:1;  plot(ttt,yexact(ttt))

% general construction of error table
nlist = 2.^(1:levels);
for k = 1:levels
    [tt,yy] = predcorr(f,t0,y0,tf,nlist(k));
    E(k) = abs(yy(end) - yexact(tf));
end
ratio = E(1:levels-1) ./ E(2:levels);
format short g                       % best looking numbers for this purpose
[nlist(2:end)', E(2:end)', ratio']   % print table vertically

