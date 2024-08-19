%DISPLAY OF COLOUR COMPONENT
image = imread("coloured 3D MRI.jpg");
figure(1);
%input image
subplot(2,3,2);
imshow(image);title("input image");
%red component
subplot(2,3,4);
red = image;
red(:,:,2) = 0;
red(:,:,3) = 0;
imshow(red); title("Red scale img");
%green component
subplot(2,3,5);
green = image;
green(:,:,1) = 0;
green(:,:,3) = 0;
imshow(green); title("Green scale img");
%blue component
subplot(2,3,6);
blue = image;
blue(:,:,1) = 0;
blue(:,:,2) = 0;
imshow(blue); title("Blue scale img");
