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
img = cv2.imread('paris.png', 0)

# Calculate threshold using Otsu's method
_, bw = cv2.threshold(img, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)

# Display the original image and the binary image
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1), plt.imshow(img, cmap='gray'), plt.title('Original Image')
plt.subplot(1, 2, 2), plt.imshow(bw, cmap='gray'), plt.title('Binary Image')
plt.show()