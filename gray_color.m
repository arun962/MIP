%DISPLAY OF GRAYSCALE IMAGE
a = imread("coloured 3D MRI.jpg");
r = a(:,:,1);
g = a(:,:,2);
b = a(:,:,3);
%input image
figure(1);
subplot(2,3,2);
imshow(a); title("Color image");
%in-built function conversion
subplot(2,3,4);
imshow(rgb2gray(a)); title("In-built function");
%average method
subplot(2,3,5);
c = (r+g+b)/3;
imshow(c); title("Average method");
%Weighted average
d = 0.299*r + 0.584*g + 0.114*b;
subplot(2,3,6);
imshow(d); title("Weighted average method");

