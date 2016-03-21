function [ result ] = ssd( img1, img2 )
%SSD Returns the l2 norm of two images with three channels eachs
%   Computes the ssd of each channel seperatly

img1_r = img1(:,:,1);
img1_g = img1(:,:,2);
img1_b = img1(:,:,3);

img2_r = img2(:,:,1);
img2_g = img2(:,:,2);
img2_b = img2(:,:,3);

ssd_r = sum((img1_r(:) - img2_r(:)).^2);
ssd_g = sum((img1_g(:) - img2_g(:)).^2);
ssd_b = sum((img1_b(:) - img2_b(:)).^2);

result = ssd_r + ssd_g + ssd_b;
end

