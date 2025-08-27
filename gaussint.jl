# plot the integrand and approximate
# the integral 
#   / 1
#   |    exp(-x^2/pi) dx
#   / 0
# by left-hand, right-hand, and
# trapezoid rules
# example:
#   julia> include("gaussint.jl")

using Plots
using Printf
using SpecialFunctions

N = 1000
dx = (1 - 0) / N;
x = range(0, 1, length=N+1)
y = exp.(- x.^2 / pi)

display(plot(x, y))

lhand = dx * sum(y[1:end-1])
@printf("lhand = %.15f\n", lhand)
rhand = dx * sum(y[2:end])
@printf("rhand = %.15f\n", rhand)
trap  = (dx/2) * sum(y[1:end-1] + y[2:end])
@printf("trap = %.15f\n", trap)
exact = (pi/2) * erf(1/sqrt(pi))
@printf("exact = %.15f\n", exact)

println("Press Enter to continue...")
readline()
