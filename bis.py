def bis(a,b,f):
  """ BIS  Apply the bisection method to solve
    f(x) = 0
  with initial bracket [a,b].
  example (after "from bis import bis"):

    def f(x):
        from math import cos
        return cos(x) - x
    r = bis(0.0,1.0,f)            
    print(f(r))                   """

  if f(a) * f(b) > 0.0:
    print "not a bracket!"; return
  for k in range(100):
    c = (a+b)/2
    r = f(c)
    if abs(r) < 1e-12: 
      return c # we are done
    elif f(a) * r >= 0.0:
      a = c
    else:
      b = c
  print "no convergence"; return

