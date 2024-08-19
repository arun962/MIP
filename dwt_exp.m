a=imread("Brain.jpg");
a = im2gray(a);
figure;
imshow(a);title("Original Image");
[ca,ch,cv,cd] = dwt2(a,'db1');
%first level decomposition
figure;
subplot(231);imshow(ca,[]);title('Low level component');
subplot(232);imshow(uint8(log(ch)),[]);title('Horizontal');
subplot(233);imshow(uint8(log(cv)),[]);title('Vertical');
subplot(234);imshow(uint8(log(cd)),[]);title('Diagonal');
rec_img = idwt2(ca,ch,cv,cd,'db1');
subplot(235);imshow(rec_img,[]);title("1st Level Reconstructed image");

%second level decomposition
figure;
[ca1,ch1,cv1,cd1] = dwt2(ca,'sym4');
subplot(231);imshow(ca1,[]);title('Low level component');
subplot(232);imshow(uint8(log(ch1)),[]);title('Horizontal');
subplot(233);imshow(uint8(log(cv1)),[]);title('Vertical');
subplot(234);imshow(uint8(log(cd1)),[]);title('Diagonal');
rec_img1 = idwt2(ca1,ch1,cv1,cd1,'sym4');
subplot(235);imshow(rec_img1,[]);title("2nd Level Reconstructed image");

%third level decomposition
figure;
[ca2,ch2,cv2,cd2] = dwt2(ca1,'sym4');
subplot(231);imshow(ca2,[]);title('Low level component');
subplot(232);imshow(uint8(log(ch2)),[]);title('Horizontal');
subplot(233);imshow(uint8(log(cv2)),[]);title('Vertical');
subplot(234);imshow(uint8(log(cd2)),[]);title('Diagonal');
rec_img2 = idwt2(ca2,ch2,cv2,cd2,'sym4');
subplot(235);imshow(rec_img2,[]);title("3rd Level Reconstructed image");