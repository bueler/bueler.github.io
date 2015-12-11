function b = mysmatvec(At,x)
% MYSMATVEC  Compute sparse mat-vec product using matrix in
% Bueler's compressed-row sparse storage format (BCRSF) and
% column vector x.  This is merely a *demonstration* of sparse
% storage.  See also MYFULL and MYSPARSE.
% Example:
%   >> Athing = bcrsfex()
%   >> x = [1 2 3 4]'
%   >> myfull(Athing) * x
%   >> mysmatvec(Athing,x)

assert (length(x) == At{1}(2))
b = zeros(At{1}(1),1);

j = 1;
r = 1;
m = 0;
while j <= length(At{3})
    for k = 1:At{3}(j)
        m = m + 1;
        b(r) = b(r) + x(At{3}(j+k)) * At{4}(m);
    end
    r = r + 1;
    j = j + At{3}(j) + 1;
end
assert (m == At{2})
