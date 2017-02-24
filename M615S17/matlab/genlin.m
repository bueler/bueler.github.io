function [x,U] = genlin(m,xL,xR,p,q,f,alpha,beta)
% GENLIN  Solve the general constant-coefficient linear second-order ODEBVP
%     u'' + p u' + q u = f(x)
% on [xL,xR] with boundary conditions u(xL)=alpha, u(xR)=beta.
% Usage:
%     [x,U] = genlin(m,xL,xR,p,q,f,alpha,beta)
% Example:  Show we generate the same numbers as from the earlier code DAVE:
%   >> [x,U] = genlin(9,0,1,0,0,@(x) sin(x),2,-3);
%   >> [xdave,Udave] = dave(9,false,@(x) sin(x),2,-3);
%   >> norm(U-Udave)
% Example with p=-20:
%   >> [x,U] = genlin(50,0,1,-20,0,@(x) zeros(size(x)),1,0);
%   >> Uexact = 1.0 - (1.0 - exp(20*x)) ./ (1.0 - exp(20));
%   >> norm(U-Uexact),  plot(x,U,x,Uexact),  legend('U','Uexact')

h = (xR - xL) / (m+1);  x = (xL+h:h:xR-h)';   % grid does not include endpoints
A = sparse(m,m);
F = f(x);                                     % f must be vectorized
for i = 1:m
    if i == 1
        A(1,[1,2]) = [-2.0/h^2 + q, 1.0/h^2 + p/(2.0*h)];
        F(1) = F(1) - alpha/h^2 + p * alpha / (2.0*h);
    elseif i == m
        A(m,[m-1,m]) = [1.0/h^2 - p/(2.0*h), -2.0/h^2 + q];
        F(m) = F(m) - beta/h^2 - p * beta / (2.0*h);
    else
        A(i,[i-1,i,i+1]) = [1.0/h^2 - p/(2.0*h), -2.0/h^2 + q, 1.0/h^2 + p/(2.0*h)];
    end
end
U = A \ F;
