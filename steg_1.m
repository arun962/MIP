%% Read the images
img1 = imread("coloured 3D MRI.jpg");
img2 = imread('MRI Brain Gray.jpg');
image1 = rgb2gray(img1);
image2 = rgb2gray(img2);
image1 = imresize(image1,[221,229]);
subplot(221);
imshow(image1);title("Input image");
subplot(222);
imshow(image2);title("Cover image");
%% bitget
a01 = bitget(image1,1);
a02 = bitget(image1,2);
a03 = bitget(image1,3);
a04 = bitget(image1,4);
a05 = bitget(image1,5);
a06 = bitget(image1,6);
a07 = bitget(image1,7);
a08 = bitget(image1,8);

b01 = bitget(image2,1);
b02 = bitget(image2,2);
b03 = bitget(image2,3);
b04 = bitget(image2,4);
b05 = bitget(image2,5);
b06 = bitget(image2,6);
b07 = bitget(image2,7);
b08 = bitget(image2,8);

C = (2 * (2 * (2 * (2 * (2 * (2 * (2 * b08 + b07) + b06) + b05) + a08) + a07) + a06) + a05);
subplot(223);
imshow(C);title("Steganographed image");
c01 = bitget(C,1);
c02 = bitget(C,2);
c03 = bitget(C,3);
c04 = bitget(C,4);

C1 = (2 * (2 * (2 * (2 * (2 * (2 * (2 * c04 + c03) + c02) + c01) + 0) + 0) + 0) + 0);
subplot(224);
imshow(C1);title("Hidden image");