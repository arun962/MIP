figure(1);
F = 150;f = 10;
t = [0:1/F:1-1/F];
a = sin(2*pi*f*t);
%1D sine plot
subplot(421);
plot(t,a);title("1D Sine");
subplot(422);
f1 = fft(a);
stem(t,abs(f1));title('1D DFT');
%1D cosine plot
subplot(423);
b = cos(2*pi*f*t);
plot(t,b);title("1D cosine");
subplot(424);
f2 = fft(b);
stem(abs(f2));title("1D DFT");
%2D sine plot
subplot(425);
k = 3; 
N = 256 ; 
x = 1:N ; 
y = 1:N ; 
[X,Y] = meshgrid(x,y) ; 
c = 1/2*(1+sin(2*pi/N*k*X)); 
surf(c);title("2D sine");
subplot(426);
f3 = fft2(c);
imagesc(abs(f3));title("2D DFT");
%2D cosine plot
subplot(427);
d = 1/2*(1+cos(2*pi/N*k*X));
surf(d);title("2D cosine");
subplot(428);
f4 = fft2(d);
imagesc(abs(f4));title("2D DFT");
%% Point operation
img = rgb2gray(imread("5.jpg"));
figure(2);
subplot(321);
imshow(img);title("Image");
%negative
subplot(322);
i = uint8(img);
L = 255;
imshow(L-i);title("Negative image");
%contrast stretching
subplot(323);
c_s = imadjust(img,stretchlim(img),[]);
imshow(c_s);title("Contrast stretched");
%compression of dynamic range
y = 0.1*log(1+double(img));
subplot(324);
imshow(y);title("Dynamic range compression");
%averaging
avg = ones(3)/9;
avg_filter = imfilter(img,avg);
subplot(325);
imshow(avg_filter);title("Averaging");
%Thresholding & binarization
T = graythresh(img);
bin = imbinarize(img,T);
subplot(326);
imshow(bin);title("Binarized img");
%% bitplane slicing
A=double(rgb2gray(imread('5.jpg')));
figure(3);
subplot(251);imshow(uint8(A));title("Original Image");
B1=bitget(A,1);
subplot(252);imshow(B1);title('Bit plane 1');
B2=bitget(A,2);
subplot(253);imshow(B2);title('Bit plane 2');
B3=bitget(A,3);
subplot(254);imshow(B3);title('Bit plane 3');
B4=bitget(A,4);
subplot(255);imshow(B4);title('Bit plane 4');
B5=bitget(A,5);
subplot(256);imshow(B5);title('Bit plane 5');
B6=bitget(A,6);
subplot(257);imshow(B6);title('Bit plane 6');
B7=bitget(A,7);
subplot(258);imshow(B7);title('Bit plane 7');
B8=bitget(A,8);
subplot(259);imshow(B8);title('Bit plane 8');
C = (2 * (2 * (2 * (2 * (2 * (2 * (2 * B8 + B7) + B6) + B5) + B4) + B3) + B2) + B1);
subplot(2,5,10);imshow(uint8(C));title("Recombined image");
%% gray level slicing
i=rgb2gray(imread('corneal view.jpg'));
j=double(i);
k=double(i);
[row,col]=size(j);
T1=50;
T2=150;
for x=1:row            
    for y=1:col        
        if((j(x,y)>T1) && (j(x,y)<T2))
            j(x,y)=i(x,y);
            k(x,y)=255;
        else
            j(x,y)=0;
            k(x,y)=0;
        end
    end
end
figure(4);
subplot(311), imshow(i), title('Original image');
subplot(312), imshow(uint8(j)), title('Graylevel slicing with background');
subplot(313), imshow(uint8(k)), title('Graylevel slicing without background');
%% smoothing and sharpening
A = imread('5.jpg');
A = rgb2gray(A);
subplot(441); imshow(A);title('Original Image');
subplot(445); imshow(A);title('Original Image');
subplot(449); imshow(A);title('Original Image');
subplot(4,4,13); imshow(A);title('Original Image');
% Adding noise
P = imnoise(A, 'poisson');
Q = imnoise(A,'gaussian');
R=imnoise(A, 'speckle',0.02);
S=imnoise(A, 'salt & pepper',0.03);

subplot(442); imshow(P);title('Image with poisson noise');
subplot(446); imshow(Q);title('Image with gaussian noise');
subplot(4,4,10); imshow(R);title('Image with speckle noise');
subplot(4,4,14); imshow(S);title('Image with S and P noise');

%Smoothening
m = [1 2 1;2 4 2;1 2 1]/16;
smoothening = imfilter(P,m);
subplot(443); imshow(smoothening);title('Smoothened image');
smoothening = imfilter(Q,m);
subplot(447); imshow(smoothening);title('Smoothened image');
smoothening = imfilter(R,m);
subplot(4,4,11); imshow(smoothening);title('Smoothened image');
smoothening = imfilter(S,m);
subplot(4,4,15); imshow(smoothening);title('Smoothened image');

%Sharpening
h = [-1 -1 -1;-1 8 1;-1 -1 -1];
sharpening = imfilter(P,h);
subplot(444); imshow(sharpening);title('Sharpened image');
sharpening = imfilter(Q,h);
subplot(448); imshow(sharpening);title('Sharpened image');
sharpening = imfilter(R,h);
subplot(4,4,12); imshow(sharpening);title('Sharpened image');
sharpening = imfilter(S,h);
subplot(4,4,16); imshow(sharpening);title('Sharpened image');

%% histogram plot
im = rgb2gray(imread("MRI Brain Gray.jpg"));
figure(5);
subplot(221);
imshow(im); title("Original image");
d = imhist(im);
subplot(222);imhist(im);title("Histogram plot");
pdf = d/numel(im);
cdf = cumsum(pdf);
l = 255;
res = uint8(cdf*l);
out = res(im+1);
subplot(223);imshow(out);title("Equalised img");
subplot(224);imhist(out);title("Histogram of Equalised img");


