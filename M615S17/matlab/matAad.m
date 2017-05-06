function A = matAad(b,D,h)
% MATAAD  The centered-space approximation of advection-diffusion equation
%     u_t + b u_x = D u_xx + f(x),
% on 0 < x < 1 with spacing h, generates an MOL system U' = A U + F.
% This code assembles A.
% Usage:   A = matAad(b,D,h)

m = round((1.0/h) - 1.0);
nu = b / (2*h);  mu = D / h^2;
A = sparse(m,m);
A(1,[1, 2]) = [-2*mu, -nu+mu];
for j = 2:m-1
   A(j,[j-1, j, j+1]) = [nu+mu, -2*mu, -nu+mu];
end
A(m,[m-1, m]) = [nu+mu, -2*mu];
