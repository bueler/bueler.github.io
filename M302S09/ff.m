
function dxxdt = ff(t,xx)

dxxdt = [xx(1) * (3 - xx(2));
         xx(2) * (xx(1) - 3)];


