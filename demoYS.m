clear all;
clc;
addpath(genpath('.'));
addpath('./Smap/Func/');
%% 设定参数
sigmaF = 6.2;
omega0 = 0.002;
img.RGB=im2double(imread('./SRC/ASD/141906.jpg'));
% img.RGB=imresize(img.RGB,[300 400]); 
%% 中心加权颜色空间分布图的计算
as=zeros(8,1);
for i=8:-1:3
    [colormap]=generate_colormaps(img.RGB,i,0);%产生彩色图     输出的结果是一种概率矩阵 M*N*X
    color_spatial_map = center_weighted_color_spatial_distribution_map(colormap);%中心加权颜色空间分布图
    imwrite(color_spatial_map,['./Saliency/ASD/141906/141906_',sprintf('%d',i),'.jpg']);
    as(i)=Information_entropy(color_spatial_map);
end
 disp(as);
 as(find(as==0))=[];%删除所有的0元素，matlab下标从1开始   
 minas=min(as);
 for j=1:6
     if as(j)==minas
         color_spatial_map=im2double(imread(['./Saliency/ASD/141906/141906_',sprintf('%d',j+2),'.jpg']));
         disp(j+2);
         imwrite(color_spatial_map,['./Smap/input/ASD_YS/141906_',sprintf('%d',j+2),'.png']);
         %% 执行快速指导滤波器FGF
         I = double(imread(['./Smap/input/ASD_YS/141906_',sprintf('%d',j+2),'.png']))/255 ;%灰度图
         p = I;
         r = 4; % try r=2, 4, or 8
         eps = 0.2^2; % try eps=0.1^2, 0.2^2, 0.4^2
         s=r/4;%try s=r;
         q = fastguidedfilter(I, p, r, eps,s);
         % figure;imshow([I, q], [0, 1]);
         q=(q-min(q(:)))/(max(q(:))-min(q(:)));
         salmaps=q*255;
         salmaps=uint8(salmaps);
         % imshow(salmaps);
         imwrite(salmaps,'./Smap/saliencymap/ASD/141906_YS.png');
     end
 end
