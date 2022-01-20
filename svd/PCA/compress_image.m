clear all;
close all;

img_rgb = imread("../../test_data/images/test.png");

img = rgb2gray(img_rgb);


[U,S,V] = svd(img);


singular_value_range = 50;

img_compressed = U(:,1:singular_value_range)*S(1:singular_value_range,1:singular_value_range)*(V')(1:singular_value_range,:);
img_compressed = uint8(img_compressed);

figure()
imshow(img)

figure()
imshow(img_compressed);