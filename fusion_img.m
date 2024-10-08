a = imread("ct.png");
a1 = rgb2gray(imresize(a,[440,270]));
b = imread("pet.png");
b1 = rgb2gray(imresize(b,[440,270]));
[ca,ch,cv,cd] = dwt2(a1,'db1');
[ca1,ch1,cv1,cd1] = dwt2(b1,'db1');
CA = ca + ca1;
CH = ch+ch1;
CV = cv+cv1;
CD = cd+cd1;
fus_img = idwt2(CA,CH,CV,CD,'db1');
subplot(131);
imshow(a1);title('Image1');
subplot(132);
imshow(b1);title('Image2');
subplot(133);
imshow(fus_img,[]);title("fused image");