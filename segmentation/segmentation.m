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

% 4. Median Thresholding: thresholding the image using median values
% threshold the image using median thresholding
median_threshold_img = gray_img > median(gray_img(:));
% show the median thresholded image
figure(5); imshow(median_threshold_img); title("Median Thresholding");

% 5. Gaussian Thresholding: thresholding the image using Gaussian values
% threshold the image using Gaussian thresholding
gaussian_threshold_img = gray_img > mean(gray_img(:)) + 2*std(double(gray_img(:)));
% show the Gaussian thresholded image
figure(6); imshow(gaussian_threshold_img); title("Gaussian Thresholding");

