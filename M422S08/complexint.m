format long g   % show more digits, as below

% generate the parameter and the function to integrate (w(t)):
t = 0:pi/1000:pi;  % divide interval [0,pi] into 1000 pieces
u = exp(i*t);
w = 2*i*u ./ (4*u.^2 + 1);

% visualize real and imaginary parts of integrand;
%   you will see immediately why integral of imaginary part
%   gives zero:
plot(t,real(w),t,imag(w)), grid on

% setup coefficients for trapezoid rule; do it:
c = 2*ones(1,1001);   c(1) = 1;   c(1001)=1;
(pi/1000) * 0.5 * sum(c * w')

% from trapezoid rule:
% ans =    0.927294823217621 + 2.32379238679825e-17i
% atan(4/3):
% ans =    0.927295218001612
% i.e. we got 6 digits correct


