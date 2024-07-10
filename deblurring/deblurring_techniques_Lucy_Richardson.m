% load image 
img = imread('C:\Users\pjcca\OneDrive\Desktop\deblurring\vegetables.jpg');

% show original image 
figure(1);
imshow(img); title('Original Image');


% 3. Lucy-Richardson Algorithm: Implements an accelerated, damped Lucy-Richardson algorithm. 
% This function performs multiple iterations, using optimization techniques and Poisson statistics.

% simulate blur and noise
PSF = fspecial("gaussian",5,5);
Blurred = imfilter(img,PSF,"symmetric","conv");
figure(2);
imshow(Blurred); title("Blurred");

V = .002;
BlurredNoisy = imnoise(Blurred,"gaussian",0,V);
figure(3);
imshow(BlurredNoisy); title("Blurred & Noisy");

% restore blurred and noisy image 
luc1 = deconvlucy(BlurredNoisy,PSF,5);
figure(4);
imshow(luc1); title("Restored Image, NUMIT = 5");

%  Control Noise Amplification by Damping
DAMPAR = im2uint8(3*sqrt(V));
luc3 = deconvlucy(BlurredNoisy,PSF,15,DAMPAR);
figure(5);
imshow(luc3); title("Restored Image with Damping, NUMIT = 15");