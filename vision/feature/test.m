

clear all;
close all;

img_rgb = imread("test.png");
img_rgb = imresize(img_rgb, 0.3);
img = rgb2gray(img_rgb);

img_rgb2 = imread("test2.png");
img_rgb2 = imresize(img_rgb2, 0.3);
img2 = rgb2gray(img_rgb2);

features = findFastCornerFeature(img);
descriptors = getBriefDescriptor(img, features);

features2 = findFastCornerFeature(img2);
descriptors2 = getBriefDescriptor(img2, features2);



figure()
imshow(img_rgb);
hold on
for i = 1:size(features,1)
    plot(features(i,2),features(i,1),'ro')
endfor

figure()
imshow(img_rgb2);
hold on
for i = 1:size(features2,1)
    plot(features2(i,2),features2(i,1),'ro')
endfor





