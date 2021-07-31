'''plot the integrand and approximate
the integral 
    / 1
    |    exp(-x^2/pi) dx
    / 0
by left-hand, right-hand, and
trapezoid rules'''

import numpy as np
import matplotlib.pyplot as plt
from scipy.special import erf

N = 1000
dx = (1.0 - 0.0) / N
x = np.linspace(0.0,1.0,N+1)
y = np.exp(- x**2 / np.pi)

plt.plot(x,y)
plt.axis([0.0,1.0,0.0,1.0])
plt.grid(True)

lhand = dx * sum(y[:-1])
print("lhand = %.15f" % lhand)
rhand = dx * sum(y[1:])
print("rhand = %.15f" % rhand)
trap  = (dx/2) * sum(y[:-1]+y[1:])
print("trap = %.15f" % trap)
exact = (np.pi/2) * erf(1/np.sqrt(np.pi))
print("exact = %.15f" % exact)
plt.show()

