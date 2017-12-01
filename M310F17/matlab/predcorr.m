function [t,Y] = predcorr(f,t0,y0,tf,N)
% PREDCORR  Applies the trapezoid rule predictor-corrector method, namely
% equations (6.32) and (6.33) in Epperson 2nd ed. 2013, to the ODE IVP
%     y' = f(t,y),  y(t0) = y0.
% Computes an estimate of y(t) on [t0,tf] at points t = t0:h:tf where
% h = (tf-t0)/N.  Compare EULERMETHOD.
% Usage:  [t,Y] = predcorr(f,t0,y0,tf,N)
% Example:
%     f = @(t,y) (1 - t) * y;
%     yexact = @(t) - exp(t - t.^2/2);
%     N = 6;  tf = 2;
%     [t,Ye] = eulermethod(f,0,-1,N,tf/N);
%     [t,Ypc] = predcorr(f,0,-1,tf,N);
%     plot(t,yexact(t),t,Ye,t,Ypc)
%     legend('exact','Euler','predictor-corrector')

h = (tf - t0) / N;
t = t0 : h : tf;
Y = zeros(1,N+1);
Y(1) = y0;
for k = 1:N
    fk = f(t(k),Y(k));
    Ytmp = Y(k) + h * fk;                          % equation (6.32)
    Y(k+1) = Y(k) + (h/2) * (fk + f(t(k+1),Ytmp));  % equation (6.33)
end

