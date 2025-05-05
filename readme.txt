TEAM MEMBERS:

KEVIN DSOUZA        4SO22CD025
ADITYA S SHETTY     4SO22CD048
TUSHAR J KOTIAN     4SO22CD061


Problem Statement :

In the rice industry, quality control is a crucial step before packaging and shipping. Traditionally, checking whether rice grains are of good length, shape, and size has been done manually by workers, which is time-consuming, labor-intensive, and often inconsistent due to human error.
The goal of this project is to automate the quality assessment of rice grains using a basic webcam and image processing techniques in MATLAB. The focus is to evaluate whether the rice grains meet a certain standard—especially in terms of **length and shape**—without needing advanced equipment.

By using morphological image processing, we aim to:

Detect individual rice grains in real-time,
Measure their geometric properties like length and width,
Determine whether the grains meet the required quality standard.

This helps in achieving a faster, objective, and repeatable method of rice quality inspection.

Techniques Used & Program Flow 

Here’s how the system works step-by-step, explained in a simple and understandable way:

1. Webcam Setup & Image Capture
The webcam is initialized and begins capturing live images of rice grains placed under it.
Each frame is treated like a snapshot and used for analysis in real-time.

2. Preprocessing the Image

First, the system converts the image to grayscale to simplify it and remove unnecessary color data.
Then it resizes the image to a fixed width (e.g., 256 pixels) while maintaining the aspect ratio.
The grayscale image is binarized (converted to black and white) using adaptive thresholding, which adjusts to varying lighting conditions.
It fills in small holes and gaps in grains using `imfill`, preparing the grains for clean analysis.

3. Morphological Processing

Erosion is applied using a disk-shaped structural element to separate closely touching grains.
Border objects (grains touching the edge of the image) are removed to avoid incomplete measurements.
The number of non-zero pixels (`nnz`) is checked to ensure there are grains in the image.

 4. Grain Area Analysis

The connected regions (grains) are labeled using `bwlabel`.
The area of each grain is calculated using `regionprops`.
The mean area is computed to understand what a typical grain size looks like.
Grains with unusually large sizes (likely stuck together) are filtered out using `bwareaopen`.

5. Length and Width Measurement

The refined grain image is re-labeled, and the system measures:

Major Axis Length (longest dimension of the grain)
Minor Axis Length (shortest dimension)
These measurements are extracted into a table and converted to arrays.

6. Aspect Ratio Calculation

The system calculates the aspect ratio for each grain (length divided by width).
This helps in identifying whether a grain is long and slender (good quality) or short and stubby (possibly broken).
It sets a threshold (e.g., ratio > 4) as a benchmark for quality.

7. Final Evaluation

If 80% or more grains have an aspect ratio higher than the threshold, the rice is considered "of good length."
Otherwise, it's rejected.
If no grains are found, it displays "No rice grains."

8. Display Results

The result (`msg`) is displayed directly on the live video using `insertText`.
The video is shown through a `VideoPlayer` window that updates with each frame.
The loop continues as long as the video window is open.





