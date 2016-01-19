function ycc = ycbcr(rgb)
% function ycc = rgb2ycc(rgb)
% convert rgb image to ycc image
% Inputs:
%   rgb    - rgb image
%
% Outputs:
%   ycc  - ycc image

% reshape image to 2d matrix
rgb = double(rgb);
[m, n, p] = size(rgb);
rgb_2d = reshape(rgb, m*n, p);
% convert parameters
origT = [0.299 0.587 0.114;...
     -0.169 -0.331 0.5; ...
     0.5 -0.419 -0.081];
% rgb to ycc
ycc_2d = origT*rgb_2d';
y = ycc_2d(1, :)';
cb = ycc_2d(2, :)';
cr = ycc_2d(3, :)';

y = reshape(y, m, n);
cb = reshape(cb, m, n);
cr = reshape(cr, m, n);
ycc = cat(3, y, cb, cr);
end

