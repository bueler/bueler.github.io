% CLASS12SEPT  Partial transcript of commands I used in-class in Math 310
% on 12 Sept. 2017

% create and test useful functions for my example:
f = @(x) x^3 + 7*x^2 + 2*x
f(1)
G = @(h) (f(1+h) - f(1))/h
G(1e-2)

% show finite difference results with reasonable format; want to get f'(1)=19:
format long
G(1e-2)
G(1e-6)
G(1e-10)
G(1e-14)
G(1e-18)

% problem for tiny h:  x+h and x are same thing
x=1
h=1e-18   % tiny
x+h == x
h=1e-14   % almost tiny
x+h == x

% illustrate overflow:  10^308 or so is largest 64-bit (double) representable
1e272
1e158
1e272 * 1e158

% underflow
1e-307    % o.k.
1e-315    % o.k. (but subnormal)
1e-330    % underflow
1e-330 == 0

% "good" h for finite differences is  sqrt(eps)  if x is of size 1
h = sqrt(eps)
G(h)

% fix definition of f so it works on lists of numbers
f = @(x) x.^3 + 7*x.^2 + 2*x

% f boring and smooth on this plot
h = 1e-4; x=1:h/100:1+h;
plot(x,f(x))

% rounding errors infect plot here
h = 1e-6; x=1:h/100:1+h;
plot(x,f(x))

% compare one-sided finite difference (G(h)) and centered-difference (K(h))
% approximations of f'(x)
K = @(h) (f(1+h) - f(1-h)) / (2*h)
h = 1e-2; G(h), K(h)
h = 1e-4; G(h), K(h)
h = 1e-6; G(h), K(h)
h = 1e-8; G(h), K(h)

