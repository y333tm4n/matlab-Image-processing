% Global Image thresholding using Otsu's method
% load image 
% img = imread('coins.png');

% % calculate threshold using graythresh
% level = graythresh(img);

% % convert into binary image using the computed threshold
% bw = imbinarize(img, level);

% % display the original image and the binary image
% figure; imshowpair(img, bw, 'montage'); title('Original Image (left) and Binary Image (right)');


% % Multi-level thresholding using Otsu's method
% % calculate single threshold using multithresh
% level = multithresh(img);

% % Segment the image into two regions using the imquantize function, specifying the threshold level returned by the multithresh function. 
% seg_img = imquantize(img,level);

% % Display the original image and the segmented image
% figure; imshowpair(img,seg_img,'montage'); title('Original Image (left) and Segmented Image (right)');


% % Global histogram threshold using Otsu's method
% % Calculate a 16-bin histogram for the image
% [counts,x] = imhist(img,16);
% stem(x,counts)

% % Compute a global threshold using the histogram counts
% T = otsuthresh(counts);

% % Create a binary image using the computed threshold and display the image
% bw = imbinarize(img,T);
% figure; imshow(bw); title('Binary Image');


%----------------------------------------------------------------------------------------------------------------------------------------------------%

% 2. Region-based segmentation

% Using K means clustering
% img2 = imread('paris.jpg');

% % Convert the image to grayscale
% bw_img2 = im2gray(img2);
% imshow(bw_img2);

% % Segment the image into three regions using k-means clustering
% [L, centers] = imsegkmeans(bw_img2,3);
% B = labeloverlay(bw_img2,L);
% imshow(B);
% title('Labled Image');

% Improvin kmeans with texture and spatial information
RBG  = imread('paris.jpg');
RGB  = imresize(RBG,0.5);
imshow(RGB);

% Segment the image into two regions using k-means clustering
L = imsegkmeans(RGB,2);
B = labeloverlay(RGB,L);
imshow(B);
title('Labeled Image');

% Create a set of 24 Gabor filters, covering 6 wavelengths and 4 orientations
wavelength = 2.^(0:5) * 3;
orientation = 0:45:135;
g = gabor(wavelength,orientation);

% Convert the image to grayscale
bw_RGB = im2gray(im2single(RGB));

% Filter the grayscale image using the Gabor filters. Display the 24 filtered images in a montage
gabormag = imgaborfilt(bw_RGB,g);
montage(gabormag,"Size",[4 6])

% Smooth each filtered image to remove local variations. Display the smoothed images in a montage
for i = 1:length(g)
    sigma = 0.5*g(i).Wavelength;
    gabormag(:,:,i) = imgaussfilt(gabormag(:,:,i),3*sigma); 
end
montage(gabormag,"Size",[4 6])

% Get the x and y coordinates of all pixels in the input image
nrows = size(RGB,1);
ncols = size(RGB,2);
[X,Y] = meshgrid(1:ncols,1:nrows);
featureSet = cat(3,bw_RGB,gabormag,X,Y);

% Segment the image into two regions using k-means clustering with the supplemented feature set
L2 = imsegkmeans(featureSet,2,"NormalizeInput",true);
C = labeloverlay(RGB,L2);
imshow(C)
title("Labeled Image with Additional Pixel Information")





