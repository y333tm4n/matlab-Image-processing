% load the image 
img = imread('C:\Users\pjcca\OneDrive\Desktop\morphology\image\sample.jpg');

% 1. Erosion
% Erosion is a morphological operation that removes pixels from the boundaries of objects in an image.

% Create a flat, line-shaped structuring element.
se = strel('line',11,90);
% Erode the image with the structuring element.
erodedBW = imerode(img,se);

% Display the original image and the eroded image.
figure(1);
imshowpair(img, erodedBW, 'montage'); title('Original Image and Eroded Image');

% Erode Grayscale Image with Rolling Ball
se = offsetstrel('ball',5,5);
% Erode the image with the structuring element.
erodedI = imerode(img,se);

% Display the original image and the eroded image using Rolling Ball.
figure(2);
imshowpair(img, erodedI, 'montage'); title('Original Image and Eroded Image using Rolling Ball');


% 2. Dilation
% Dilation is a morphological operation that adds pixels to the boundaries of objects in an image.

% Create a vertical line shaped structuring element.
se = strel('line',11,90);

% Dilate the image with the structuring element.
dilatedBW = imdilate(img,se);

% Display the original image and the dilated image.
figure(3);
imshowpair(img, dilatedBW, 'montage'); title('Original Image and Dilated Image');

% Dilate Grayscale Image with Rolling Ball
se = offsetstrel('ball',5,5);
% Dilate the image with the structuring element.
dilatedI = imdilate(img,se);

% Display the original image and the dilated image.
figure(4);
imshowpair(img, dilatedI, 'montage'); title('Original Image and Dilated Image using Rolling Ball');

% 3. Opening
% Opening is a morphological operation that consists of an erosion followed by a dilation.

% load image 
img2 = imread('C:\Users\pjcca\OneDrive\Desktop\morphology\image\snowflake.png');

% create a disk-shaped structuring element with a radius of 5.
se = strel('disk',5);

% Perform opening on the image using the structuring element.
openedBW = imopen(img2,se);

% Display the original image and the opened image.
figure(5);
imshowpair(img2, openedBW, 'montage'); title('Original Image and Opened Image');

% 4. Closing
% Closing is a morphological operation that consists of a dilation followed by an erosion.

img3 = imread('C:\Users\pjcca\OneDrive\Desktop\morphology\image\circles.png');

%Create a disk-shaped structuring element. Use a disk structuring element to preserve the circular nature of the object. 
% Specify a radius of 10 pixels so that the largest gap gets filled.
se = strel('disk',10);

% Perform closing on the image using the structuring element.
closedBW = imclose(img3,se);

% Display the original image and the closed image.
figure(6); imshowpair(img3, closedBW, 'montage'); title('Original Image and Closed Image'); 

% add sample comment to test git