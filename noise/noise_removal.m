% load image 
img = imread('coins.png');

% show image 
figure(1);
imshow(img); title('Original Image')

% add noise
noise = imnoise(img, "salt & pepper", 0.02);
figure(2);
imshow(noise); title('Noise with Salt and Peper filter');

% filter image
Kaverage = filter2(fspecial('average',3),img)/255;
figure(3);
imshow(Kaverage); title('Filtered Image');

% filter using median median filter 
Kmedian = medfilt2(img);
figure(4)
imshowpair(Kaverage,Kmedian,'montage'); title('Comparsion between regular and median filtering'); 





