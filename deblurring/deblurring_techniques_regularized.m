% load image 
img = imread('C:\Users\pjcca\OneDrive\Desktop\deblurring\vegetables.jpg');

% show original image 
figure(1);
imshow(img); title('Original Image');


% 2. Regularized Filter: Implements a constrained least squares solution, where you can place constraints on the output image 
%-------------------------------------------------------------------%
% blur the image
PSF = fspecial("gaussian",11,5);
blurred = imfilter(img,PSF,"conv");

noise_mean = 0;
noise_var = 0.02;
blurred_noisy = imnoise(blurred,"gaussian",noise_mean,noise_var);

figure(2)
imshow(blurred_noisy); title("Blurred and Noisy Image")

% Restore Image Using Estimated Noise Power
NP = noise_var*numel(img);
[reg1,lagra] = deconvreg(blurred_noisy,PSF,NP);
figure(3);
imshow(reg1); title("Restored with True NP");

% using large NP Value
NP_value1 = 1.1;
reg2 = deconvreg(blurred_noisy, PSF, NP*NP_value1);
figure(4);
imshow(reg2); title("Restored with Larger NP");

% using small NP Value
NP_value2 = 0.9;
reg2 = deconvreg(blurred_noisy, PSF, NP*NP_value2);
figure(5);
imshow(reg2); title("Restored with Smaller NP");

% Reduce Noise Amplification and Ringing
tapered = edgetaper(blurred_noisy,PSF);
reg4 = deconvreg(tapered,PSF,NP*NP_value2);
figure(6);
imshow(reg4); title("Restored with Smaller NP and Edge Tapering");

lagra_value1 = 100; % will result to oversmoothing of the image
reg6 = deconvreg(tapered,PSF,[],lagra*lagra_value1);
figure(7);
imshow(reg6); title("Restored with Large LAGRA");

lagra_value2 = 0.01; 
reg6 = deconvreg(tapered,PSF,[],lagra*lagra_value2);
figure(8);
imshow(reg6); title("Restored with Small LAGRA")
