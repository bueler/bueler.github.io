function A = myfull(At)
% MYFULL  Convert matrix in Bueler's compressed-row sparse
% storage format (BCRSF) to conventional form.  This is merely
% a *demonstration* of sparse storage.  See MYSPARSE and MYSMATVEC.
% Example:
%   >> Athing = bcrsfex()
%   >> A = myfull(Athing)
%   >> Athinger = mysparse(A)

% allocate
A = zeros(At{1}(1),At{1}(2));

% fill
p = 1;   % row of A
j = 1;   % location of row nnz count
s = 0;   % index into entries list
while j <= length(At{3})
    for k = 1:At{3}(j)
        s = s + 1;
        A(p,At{3}(j+k)) = At{4}(s);
    end
    p = p + 1;
    j = j + At{3}(j) + 1;
end
assert (s == At{2}(1))

