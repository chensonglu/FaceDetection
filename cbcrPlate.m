function [cb_mean, cr_mean, cb_std, cr_std] = cbcrPlate(cb_scale, cr_scale)
% function [cb_mean, cr_mean, cb_std, cr_std] = cbcrPlate(cb_scale, cr_scale)
% plot Cb-Cr plate of all training images
% Inputs:
%   cb_scale - cb_std scale
%   cr_scale - cr_std scale
%
% Outputs:
%   cb_mean  - mean of cb
%   cr_mean  - mean of cr
%   cb_std   - std of cb
%   cr_std   - std of cr

y_all = []; cb_all = []; cr_all = [];
for i = 1:7
    trainImg_RGB = imread(['./imgs/Training_' num2str(i) '.jpg']); % RGB image
    refImg = imread(['./imgs/ref' num2str(i) '.png']); % Ground Truth image
    trainImg_YCbCr = ycbcr(trainImg_RGB); % YCbCr image

    % y, cb, cr channels of each image
    y = trainImg_YCbCr(:, :, 1);
    cb = trainImg_YCbCr(:, :, 2);
    cr = trainImg_YCbCr(:, :, 3);
    % all y, cb, cr of 7 images 
    y_ref = y(refImg ~= 0);
    cb_ref = cb(refImg ~= 0);
    cr_ref = cr(refImg ~= 0);
    y_all = [y_all; y_ref];
    cb_all = [cb_all; cb_ref];
    cr_all = [cr_all; cr_ref];
end
% mean and std of cb, cr
cb_mean = mean(cb_all);
cr_mean = mean(cr_all);
cb_std = std(cb_all);
cr_std = std(cr_all);
sprintf('mean of cb:%f\n mean of cr\n std of cb:%f\n std of cr:%f\n',...
    cb_mean, cr_mean, cb_std, cr_std);
% plot Cb-Cr plate
% plot(cb_all, cr_all, 'r');
% xlabel('Cb'), ylabel('Cr');
% rectangle('Position', [cb_mean - cb_scale*cb_std cr_mean - cr_scale*cr_std ...
%     2*cb_scale*cb_std 2*cr_scale*cr_std], 'EdgeColor', 'g');
end