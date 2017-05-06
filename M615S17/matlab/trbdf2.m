function [U,NN] = trbdf2(A,U0,k,tf)
% TRBDF2  Solve a homogeneous linear (system) ODE IVP,
%   U' = A U,  U(0) = U0
% by the TR-BDF2 method (formula (8.6) in LeVeque 2007).
% Usage:  [U,N] = trbdf2(A,U0,k,tf)
% computes U = U(tf) by N steps of size k to reach final time tf.

s = length(U0);
if ~all(size(A) == [s s]),  error('size of A must match U0'),  end
NN = ceil(tf / k);
k = tf / NN;
U = U0;
for n = 1:NN
   Ustar = (eye(s,s) - (k/4)*A) \ (U + (k/4)*A*U);
   U = (eye(s,s) - (k/3)*A) \ ((1/3) * (4 * Ustar - U));
end

