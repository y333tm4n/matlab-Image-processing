import cv2
import numpy as np
import matplotlib.pyplot as plt
from skimage import filters, color
from skimage.segmentation import slic, mark_boundaries
from sklearn.cluster import KMeans
from scipy.ndimage import label
from skimage.filters import gabor
from skimage.util import img_as_float
from skimage.restoration import denoise_tv_chambolle

# Global Image Thresholding using Otsu's method
# Load image
img = cv2.imread('C:\\Users\\luis\\Desktop\\Programs\\Image-Processing\\matlab-Image-processing\\segmentation\\coins.png', 0)

# Calculate threshold using Otsu's method
_, bw = cv2.threshold(img, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)

# Display the original image and the binary image
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1), plt.imshow(img, cmap='gray'), plt.title('Original Image')
plt.subplot(1, 2, 2), plt.imshow(bw, cmap='gray'), plt.title('Binary Image')
plt.show()

# Multi-level thresholding using Otsu's method
# Calculate single threshold using Otsu's method
level = filters.threshold_multiotsu(img)

# Segment the image
seg_img = np.digitize(img, bins=level)

# Display the original image and the segmented image
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1), plt.imshow(img, cmap='gray'), plt.title('Original Image')
plt.subplot(1, 2, 2), plt.imshow(seg_img, cmap='gray'), plt.title('Segmented Image')
plt.show()

# Global histogram threshold using Otsu's method
# Calculate a 16-bin histogram for the image
hist, bins = np.histogram(img.flatten(), 16, [0, 256])

# Compute a global threshold using the histogram counts
T = filters.threshold_otsu(img)

# Create a binary image using the computed threshold and display the image
_, bw = cv2.threshold(img, T, 255, cv2.THRESH_BINARY)
plt.figure(), plt.imshow(bw, cmap='gray'), plt.title('Binary Image')
plt.show()

# Region-based segmentation using K means clustering
# Load image
img2 = cv2.imread('C:\\Users\\luis\\Desktop\\Programs\\Image-Processing\\matlab-Image-processing\\segmentation\\paris.jpg')
img2_gray = cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)

# Segment the image into three regions using K-means clustering
pixel_values = img2_gray.reshape((-1, 1))
kmeans = KMeans(n_clusters=3, random_state=0).fit(pixel_values)
segmented_img = kmeans.labels_.reshape(img2_gray.shape)

# Display the labeled image
plt.figure(), plt.imshow(segmented_img, cmap='gray'), plt.title('Labeled Image')
plt.show()

# Using connected-component labeling
# Convert the image to binary
_, bin_img2 = cv2.threshold(img2_gray, T, 255, cv2.THRESH_BINARY)

# Label the connected components
num_labels, labeled_img = cv2.connectedComponents(bin_img2)

# Display the number of connected components
print(f'Number of connected components: {num_labels - 1}')

# Assign a different color to each connected component
colored_labels = cv2.applyColorMap((labeled_img * 10).astype(np.uint8), cv2.COLORMAP_HSV)

# Display the labeled image
plt.figure(), plt.imshow(colored_labels), plt.title('Labeled Image')
plt.show()

# Adding noise to the image then segmenting it using Otsu's method
img_noise = cv2.imread('C:\\Users\\luis\\Desktop\\Programs\\Image-Processing\\matlab-Image-processing\\segmentation\\coins.png', 0)
img_noise = cv2.randn(img_noise, 0, 255)
img_noise = cv2.medianBlur(img_noise, 5)

# Calculate single threshold using Otsu's method
level = filters.threshold_multiotsu(img_noise)

# Segment the image
seg_img = np.digitize(img_noise, bins=level)

# Display the original image and the segmented image
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1), plt.imshow(img_noise, cmap='gray'), plt.title('Original Image with Noise')
plt.subplot(1, 2, 2), plt.imshow(seg_img, cmap='gray'), plt.title('Segmented Image')
plt.show()

# Segment the image into two regions using k-means clustering
img_rgb = cv2.imread('C:\\Users\\luis\\Desktop\\Programs\\Image-Processing\\matlab-Image-processing\\segmentation\\coins.png')
img_rgb = cv2.cvtColor(img_rgb, cv2.COLOR_BGR2RGB)
pixel_values = img_rgb.reshape((-1, 3))
kmeans = KMeans(n_clusters=2, random_state=0).fit(pixel_values)
segmented_img = kmeans.labels_.reshape(img_rgb.shape[:2])

# Display the labeled image
plt.figure(), plt.imshow(mark_boundaries(img_rgb, segmented_img)), plt.title('Labeled Image')
plt.show()

# Create a set of 24 Gabor filters
wavelengths = [3, 6, 12, 24, 48, 96]
orientations = [0, 45, 90, 135]
gabor_filters = []

for wavelength in wavelengths:
    for orientation in orientations:
        gabor_filters.append(gabor(img_as_float(img_rgb), frequency=1/wavelength, theta=np.deg2rad(orientation)))

# Convert the image to grayscale
img_gray = cv2.cvtColor(img_rgb, cv2.COLOR_RGB2GRAY)

# Filter the grayscale image using the Gabor filters
gabor_mag = np.array([np.sqrt(np.square(np.real(gf[0])) + np.square(np.imag(gf[0]))) for gf in gabor_filters])

# Display the filtered images in a montage
plt.figure(figsize=(12, 8))
for i in range(len(gabor_mag)):
    plt.subplot(4, 6, i+1), plt.imshow(gabor_mag[i], cmap='gray'), plt.title(f'Filter {i+1}')
plt.show()

# Smooth each filtered image to remove local variations
gabor_mag_smoothed = [denoise_tv_chambolle(gm, weight=0.1) for gm in gabor_mag]

# Display the smoothed images in a montage
plt.figure(figsize=(12, 8))
for i in range(len(gabor_mag_smoothed)):
    plt.subplot(4, 6, i+1), plt.imshow(gabor_mag_smoothed[i], cmap='gray'), plt.title(f'Smoothed {i+1}')
plt.show()

# Get the x and y coordinates of all pixels in the input image
rows, cols = img_rgb.shape[:2]
x, y = np.meshgrid(np.arange(cols), np.arange(rows))
features = np.stack([img_gray, *gabor_mag_smoothed, x, y], axis=-1).reshape((-1, 26))

# Segment the image into two regions using k-means clustering with the supplemented feature set
kmeans = KMeans(n_clusters=2, random_state=0).fit(features)
labeled_img = kmeans.labels_.reshape(img_rgb.shape[:2])

# Display the labeled image with additional pixel information
plt.figure(), plt.imshow(mark_boundaries(img_rgb, labeled_img)), plt.title('Labeled Image with Additional Pixel Information')
plt.show()