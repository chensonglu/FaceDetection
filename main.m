clear;
clc;
close all;
format compact;
format long;

RGBImg = imread('./imgs/TestImage.jpg');
grayImg = rgb2gray(RGBImg);
cb_scale = 2;
cr_scale = 1;
% statistical information
[cb_mean, cr_mean, cb_std, cr_std] = cbcrPlate(cb_scale, cr_scale)
% image binarization
result = FaceBinarization(RGBImg, cb_mean, cr_mean, cb_std, cr_std, cb_scale, cr_scale);
% fill background holes
result = bwfill(result, 'holes');
% remove isolated small white area
result = bwareaopen(result, 500);
% erosion
result = imerode(result, ones(5));
% Robert edge
edgeImg = edge(grayImg, 'roberts', 0.1);
edgeImg = ~edgeImg;
% integeration of 2 images, result + edge image
result = 255*(double(result) & double(edgeImg));
% erosion
result = imerode(result, ones(5));
% fill background holes
result = bwfill(result, 'holes');
% remove isolated small white area
result = bwareaopen(result, 500);
% group labeling
[segments, num_segments] = bwlabel(result);
status = regionprops(segments, 'BoundingBox');

width_all = []; height_all = [];
for i=1:num_segments
    width_all = [width_all; status(i).BoundingBox(3)];
    height_all = [height_all; status(i).BoundingBox(4)];
end
% figure;
% subplot(221), hist(width_all, 50), title('标记区域宽的分布图');
% subplot(222), hist(height_all, 50), title('标记区域高的分布图');
% subplot(223), hist(height_all./width_all, 50), title('标记区域高宽比的分布图');

% show labeled image
figure, imshow(RGBImg);
for i=1:num_segments
    width = status(i).BoundingBox(3);
    height = status(i).BoundingBox(4);
    ratio = height/width;
    if ratio > 3 || ratio < 0.75 || (width < 40 & height < 50) continue; end
    rectangle('position', status(i).BoundingBox, 'edgecolor', 'r');
end 