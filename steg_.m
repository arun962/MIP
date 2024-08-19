%% Read the images
img1 = imread("coloured 3D MRI.jpg");
img2 = imread('MRI Brain Gray.jpg');
image1 = rgb2gray(img1);
image2 = rgb2gray(img2);
image1 = imresize(image1,[221,229]);
[a, b] = size(image1);
[r, c] = size(image2);
%% Image Hiding
MSB = bitplaneslice(image2, 8, r, c);
MSB2 = bitplaneslice(image2, 7, r, c);
MSB3 = bitplaneslice(image2, 6, r, c);
New_Image = bitset(image1, 1, MSB);
New_Image = bitset(New_Image, 2, MSB2);
New_Image = bitset(New_Image, 3, MSB3);
MSB_Image = zeros(r,c,3);
MSB_Image(:, :, 1) = MSB3;
MSB_Image(:, :, 2) = MSB2;
MSB_Image(:, :, 3) = MSB;
%% Plotting the Images
subplot(221)
imshow(image1);
title('Image 1');
subplot(222)
imshow(image2);
title('Image 2');
subplot(223)
imshow(New_Image)
title('Hidden Image');
subplot(224)
imshow(rgb2gray(double(MSB_Image)));
title('8th Bit Plane of Image 2');
%% Function to receive the bitplane required
function y = bitplaneslice(image, bitplane, r, c)
C = zeros(r, c);
for i=1:r
for j=1:c
C(i,j) = bitget(image(i,j), bitplane);
end
end
y = C;
end
