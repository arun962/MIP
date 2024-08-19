im = imread("MRI Brain Gray.jpg");
im = rgb2gray(im);
i = dct2(double(im));