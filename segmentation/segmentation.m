% Global Image thresholding using Otsu's method
% load image 
img = imread('coins.png');

% calculate threshold using graythresh
level = graythresh(img);

% convert into binary image using the computed threshold
bw = imbinarize(img, level);

% display the original image and the binary image
figure; imshowpair(img, bw, 'montage'); title('Original Image (left) and Binary Image (right)');


% Multi-level thresholding using Otsu's method
% calculate single threshold using multithresh
level = multithresh(img);

% Segment the image into two regions using the imquantize function, specifying the threshold level returned by the multithresh function. 
seg_img = imquantize(img,level);

% Display the original image and the segmented image
figure; imshowpair(img,seg_img,'montage'); title('Original Image (left) and Segmented Image (right)');


% Global histogram threshold using Otsu's method
% Calculate a 16-bin histogram for the image
[counts,x] = imhist(img,16);
stem(x,counts)

% Compute a global threshold using the histogram counts
T = otsuthresh(counts);

% Create a binary image using the computed threshold and display the image
bw = imbinarize(img,T);
figure; imshow(bw); title('Binary Image');




