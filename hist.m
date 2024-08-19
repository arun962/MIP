im = imread("MRI Brain Gray.jpg");
l = 255;
freq = imhist(im); 
pdf = freq/sum(freq);
cdf = cumsum(pdf);
res = uint8(cdf*l);
out = res(im+1);
subplot(2,2,1);
imshow(im); title("Grayscale image");
subplot(2,2,2);
imshow(out);title("Histogram equalized image");
subplot(2,2,3);
imhist(im);
subplot(2,2,4);
imhist(out);

    