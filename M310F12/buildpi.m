% BUILDPI estimate pi by generating random numbers

N = 100000;
count = 0;
for j = 1:N
  x = 2*rand - 1;
  y = 2*rand - 1;
  if x^2 + y^2 < 1
    count = count + 1;
  end
end
piestimate = 4 * count / N
