function blockimage(A)
% BLOCKIMAGE  Generate a monochrome block image of a matrix
% using IMAGESC.  Example:
%   >> blockimage(magic(5))

colormap('gray')      % make a monochrome image
imagesc(A)            % show A as an image using scaled shading
axis equal, axis off  % each entry is a square; declutter
