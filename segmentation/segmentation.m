% segmentation techniques for image processing available in MATLAB
% load the image 
img = imread("sunflower.jpg");
% show image 
figure(1); imshow(img); title("Original Image");


% 1. Global Thresholding: thresholding the image using a single value
% convert the image to grayscale
gray_img = rgb2gray(img);
% threshold the image
threshold = 100;
threshold_img = gray_img > threshold;
% show the thresholded image
figure(2); imshow(threshold_img); title("Global Thresholding");

% 2. Adaptive Thresholding: thresholding the image using local values
% threshold the image using adaptive thresholding
adaptive_threshold_img = adaptthresh(gray_img, 0.4);
adaptive_threshold_img = imbinarize(gray_img, adaptive_threshold_img);
% show the adaptive thresholded image
figure(3); imshow(adaptive_threshold_img); title("Adaptive Thresholding");

% 3. Otsu's Thresholding: thresholding the image using Otsu's method
gray_img = rgb2gray(img);
% Otsu's method for thresholding
level = graythresh(gray_img);  % Compute the Otsu threshold
BW = imbinarize(gray_img, level);  % Apply the threshold
% Display the result
figure(4); imshow(BW); title('Otsu''s Method');