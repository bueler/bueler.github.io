import numpy as np
import scipy as sp
import matplotlib as ml
import matplotlib.pyplot as plt
from scipy.sparse.linalg import spsolve

J = 20
N = 20
tf = 0.1

dt = tf / N
dx = 1.0 / J
mu = dt / dx**2
print 'mu = ', mu
x = np.arange(0,1+dx,dx)
t = np.arange(0,tf+dt,dt)

# assemble matrix row by row; see equation (2.64) in Morton & Mayers
# assemble in linked list form
A = sp.sparse.lil_matrix((J-1,J-1))
A[0,0] = 1 + 2*mu
A[0,1] = -mu
for j in range(1,J-2):
  A[j,j-1] = - mu
  A[j,j]   = 1 + 2*mu
  A[j,j+1] = - mu
A[J-2,J-3] = - mu
A[J-2,J-2] = 1 + 2*mu
# will solve in compressed row storage
A = A.tocsr()

# to look at matrix:
#print A.todense()           # equivalent of "full(A)" in Matlab
#plt.figure(1),  plt.spy(A)

# numerically-approximate PDE
U = np.zeros((N+1,J+1))      # allocate space
U[0,:] = np.sin(2.0*np.pi*x) # set initial condition; implicitly a for loop
for n in range(N):
  b = U[n,1:J]               # right side of system from U at t_n
  v = spsolve(A,b)           # solve system
  U[n+1,1:J] = v.transpose() # update U at t_{n+1}
  U[n+1,0] = 0               # set boundary conditions
  U[n+1,J] = 0

fig = plt.figure(2)
pc = plt.pcolormesh(U);  cbar = fig.colorbar(pc)
plt.xlabel('x');  plt.ylabel('t');  plt.axis('tight')

plt.show()

