function M = hello;
% HELLO Assembles HELLO matrix.  See Trefethen&Bau Exercise 9.3.

bl = ones(8,6);
H = bl;
H(1:3,3:4) = zeros(3,2);
H(6:8,3:4) = zeros(3,2);
E = bl;
E(3,3:6)   = zeros(1,4); 
E(6,3:6)   = zeros(1,4); 
L = bl;
L(1:6,3:6) = zeros(6,4);
O = bl;
O(3:6,3:4) = zeros(4,2);

M = zeros(15,40);
M(2:9,2:7)    = H;
M(3:10,10:15) = E;
M(4:11,18:23) = L;
M(5:12,26:31) = L;
M(6:13,34:39) = O;

