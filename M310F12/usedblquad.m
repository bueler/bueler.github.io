function usedblquad
% USEDBLQUAD  compute an integral using *black box* dblquad.
% Compare to MONTE2D.

dblquad(@fhard,0,2,0,1)

  function z = fhard(x,y)
    z = zeros(size(x));
    for j=1:length(x)
      if (y > x(j)^2/4) & (y < exp(-x(j)))
        z(j) = cos(x(j)^3 + y);
      end
    end
  end

end
