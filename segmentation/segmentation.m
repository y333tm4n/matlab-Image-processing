% load the image 
img = imread("sunflower.jpg");


% convert the image to grayscale
gray_img = rgb2gray(img);

% using global thresholding
% compute the global threshold value
threshold = graythresh(gray_img);

% apply the threshold to the image
bw_img = imbinarize(gray_img, threshold);

% display the original and the segmented image
figure(1);
imshowpair(img, bw_img, 'montage'); title('Original Image (left) vs. Segmented Image (right)');

% using adaptive thresholding
% apply the adaptive threshold to the image
at_value = adaptthresh(gray_img, 0.4, 'ForegroundPolarity', 'dark');

% convert the adaptive threshold to a binary image
at_img = imbinarize(gray_img, at_value);

% display the original and the segmented image
figure(2);
imshowpair(img, at_img, 'montage'); title('Original Image (left) vs. Segmented Image (right)');

% using Otsu's method
% calculate the histogram for the image
[counts, x] = imhist(gray_img, 16);

% calculate otsu's threshold
otsu_value = otsuthresh(counts);

% apply the threshold to the image
otsu_img = imbinarize(gray_img, otsu_value);

% display the original and the segmented image
figure(3);
imshowpair(img, otsu_img, 'montage'); title('Original Image (left) vs. Segmented Image (right)');

