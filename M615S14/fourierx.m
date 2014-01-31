function fourierx(NN,color)
% FOURIERX plots the NN th partial sum of the Fourier sine approximation of x

x = 0:.002:1;    % a fine grid of 500 spaces
sign = +1;       % sum starts with this sign
s = (2 * sign / pi) * sin(pi * x);
for n = 2:NN
  sign = sign * -1;
  s = s + (2 * sign / (n * pi)) * sin(n * pi * x);
end
plot(x,s,color,'linewidth',2.0)
