% load image 
img = imread('C:\Users\pjcca\OneDrive\Desktop\deblurring\vegetables.jpg');

% show original image 
figure(1);
imshow(img); title('Original Image');

% Deblurring Techniques
% 1. Wiener Filter: Implements a least squares solution
%-------------------------------------------------------------------%
% blur the image 
PSF = fspecial('motion',21,11);
imgdouble = im2double(img);
blurred = imfilter(imgdouble,PSF,'conv','circular');
figure(2);
imshow(blurred); title('Blurred Image')

% Restore the blurred image by using the deconvwnr function
wnr1 = deconvwnr(blurred,PSF);
figure(3);
imshow(wnr1); title('Restored Blurred Image');

% with motion blur and Gaussian Noise
noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(blurred,'gaussian',noise_mean,noise_var);
figure(4);
imshow(blurred_noisy); title('Blurred and Noisy Image')

% restore image with estimated NSR
signal_var = var(imgdouble(:));
NSR = noise_var / signal_var;
wnr3 = deconvwnr(blurred_noisy,PSF,NSR);
figure(5)
imshow(wnr3); title('Restoration of Blurred Noisy Image (Estimated NSR)');

% with Motion Blur and 8-Bit Quantization Noise
blurred_quantized = imfilter(img,PSF,'conv','circular');
figure(6);
imshow(blurred_quantized); title('Blurred Quantized Image');

% restore image with estimated NSR
uniform_quantization_var = (1/256)^2 / 12;
signal_var = var(imgdouble(:));
NSR = uniform_quantization_var / signal_var;
wnr5 = deconvwnr(blurred_quantized,PSF,NSR);
figure(7);
imshow(wnr5); title('Restoration of Blurred Quantized Image (Estimated NSR)');
