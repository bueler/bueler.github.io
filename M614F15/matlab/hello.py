# HELLO Assembles HELLO matrix.  See Trefethen&Bau Exercise 9.3.
from pylab import ones, zeros, spy, show

bl = ones((8,6))
H = bl.copy()
H[0:3,2:4] = zeros((3,2))
H[5:8,2:4] = zeros((3,2))
E = bl.copy()
E[2,2:6]   = zeros((1,4))
E[5,2:6]   = zeros((1,4)) 
L = bl.copy()
L[0:6,2:6] = zeros((6,4))
O = bl.copy()
O[2:6,2:4] = zeros((4,2))

HELLO = zeros((15,40))
HELLO[1:9,1:7]    = H
HELLO[2:10,9:15]  = E
HELLO[3:11,17:23] = L
HELLO[4:12,25:31] = L
HELLO[5:13,33:39] = O

spy(HELLO,marker='.'); show()
