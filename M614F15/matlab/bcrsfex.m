function Athing = bcrsfex()
% BCRSFEX  Generate an example matrix in Bueler's
% compressed-row sparse storage format (BCRSF).  See MYFULL,
% MYSPARSE, and MYSMATVEC.
% Example:
%   >> Athing = bcrsfex()
%   >> Athing{1}           % size [m n]
%   >> Athing{2}           % nnz = number of nonzeros
%   >> Athing{3}           % integer array with row nnz count and col indices
%   >> Athing{4}           % real entries of A
%   >> myfull(Athing)      % conventional form

Athing = { [4 4],
           8,
           [2 1 2 2 1 2 3 2 3 4 1 4],
           [3.0 5.0 7.0 3.0 2.0 3.0 1.0 3.0] };

