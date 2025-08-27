"""
    bis(a, b, f)

Apply the bisection method to solve f(x) = 0 with initial bracket [a,b].

# Example
```julia
f(x) = cos(x) - x      # define function
r = bis(0, 1, f)       # find root
f(r)                   # confirm result
```
"""
function bis(a,b,f)

if f(a) * f(b) > 0
  error("not a bracket!")
end
for k = 1:100
  c = (a+b)/2
  r = f(c)
  if abs(r) < 1e-12 
    return c
  elseif f(a) * r >= 0.0 
    a = c
  else
    b = c
  end
end
error("no convergence")
end  # function
