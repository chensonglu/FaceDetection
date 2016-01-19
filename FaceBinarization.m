function result = FaceBinarization(RGBImage, cb_mean, cr_mean, cb_std, cr_std, cb_scale, cr_scale)
% FaceBinarization returns binary image with skin-colored area white.

% YCbCr image
YCbCrImage = ycbcr(RGBImage);
% image initialization
imgRow = size(YCbCrImage, 1);
imgCol = size(YCbCrImage, 2);
Cb = zeros(imgRow, imgCol);
Cr = zeros(imgRow, imgCol);
% binarization
cb_min = cb_mean - cb_scale*cb_std;
cb_max = cb_mean + cb_scale*cb_std;
cr_min = cr_mean - cr_scale*cr_std;
cr_max = cr_mean + cr_scale*cr_std;
Cb(YCbCrImage(:, :, 2) > cb_min & YCbCrImage(:, :, 2) < cb_max) = 1;
Cr(YCbCrImage(:, :, 3) > cr_min & YCbCrImage(:, :, 3) < cr_max) = 1;
% binary image
result=255*(Cb.*Cr);