clear all;
clc;
addpath('./Func/');
I=im2double(imread('./input/ASD/109297.jpg'));%灰度图像或彩色图像都可以
lbpI = lbp(I);
% lbpI=lbp_rotation(I);
[r c]=size(rgb2gray(I));
%imshow(lbpI);
lbpI=imresize(lbpI,[r c]);
imshow(lbpI);
imwrite(lbpI,'./saliencymapLBP/ASD_LBProtation/109297_LBP.png');
