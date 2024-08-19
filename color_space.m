F=imread('coloured 3D MRI.jpg'); 
F=im2double(F); 
r=F(:,:,1); 
g=F(:,:,2); 
b=F(:,:,3); 
theta=acos((0.5*((r-g)+(r-b)))./((sqrt((r-g).^2+(r-b).*(g-b))))); 
H=theta; 
H(b>g)=2*pi-H(b>g); 
H=H/(2*pi); 
S=1-3.*(min(min(r,g),b))./(r+g+b);
I=(r+g+b)/3; 
hsi=cat(3,H,S,I); 
figure(1),subplot(231);imshow(F);title('RGB Image');
subplot(232), imshow(hsi), title('HSI IMAGE'); 
imwrite(hsi,'hsi.png');
% %% HSI TO RGB W/O INBUILT 
hsi1=imread('hsi.png'); 
HSI=im2double(hsi); 
H1=HSI(:,:,1); 
S1=HSI(:,:,2); 
I1=HSI(:,:,3); 
H1=H1*360; 
%Preallocate the R,G and B components 
R1=zeros(size(H1)); 
G1=zeros(size(H1)); 
B1=zeros(size(H1)); 
RGB1=zeros([size(H1),3]); 
%RG Sector(0<=H<120) 
%When H is in the above sector, the RGB components equations are 
B1(H1<120)=I1(H1<120).*(1-S1(H1<120)); 
R1(H1<120)=I1(H1<120).*(1+((S1(H1<120).*cosd(H1(H1<120)))./cosd(60-H1(H1<120)))); 
G1(H1<120)=3.*I1(H1<120)-(R1(H1<120)+B1(H1<120));
%GB Sector(120<=H<240) 
%When H is in the above sector, the RGB components equations are 
%Subtract 120 from Hue 
H2=H1-120;
R1(H1>=120&H1<240)=I1(H1>=120&H1<240).*(1-S1(H1>=120&H1<240)); 
G1(H1>=120&H1<240)=I1(H1>=120&H1<240).*(1+((S1(H1>=120&H1<240).*cosd(H2(H1>=120&H1<240)))./cosd(60-H2(H1>=120&H1<240)))); 
B1(H1>=120&H1<240)=3.*I1(H1>=120&H1<240)-(R1(H1>=120&H1<240)+G1(H1>=120&H1<240)); 
%BR Sector(240<=H<=360) 
%When H is in the above sector, the RGB components equations are 
%Subtract 240 from Hue 
H2=H1-240; 
G1(H1>=240&H1<=360)=I1(H1>=240&H1<=360).*(1-S1(H1>=240&H1<=360)); 
B1(H1>=240&H1<=360)=I1(H1>=240&H1<=360).*(1+((S1(H1>=240&H1<=360).*cosd(H2(H1>=240&H1<=360)))./cosd(60-H2(H1>=240&H1<=360)))); 
R1(H1>=240&H1<=360)=3.*I1(H1>=240&H1<=360)-(G1(H1>=240&H1<=360)+B1(H1>=240&H1<=360));
%Form RGB Image 
RGB1(:,:,1)=R1; 
RGB1(:,:,2)=G1; 
RGB1(:,:,3)=B1; 
%Represent the image in the range [0 255] 
RGB1=im2uint8(RGB1); 
subplot(1,2,2);imshow(RGB1);title('RGB Image');
%% RGB TO CMY W/O INBUILT 
RGB = imread('coloured 3D MRI.jpg'); 
RGB = im2double(RGB); 
R = RGB(:,:,1); 
G = RGB(:,:,2); 
B = RGB(:,:,3);
C=1.-R; 
M=1.-G; 
Y=1.-B; 
CMY=cat(3,C,M,Y); 
subplot(2,3,5), imshow(CMY), title('CMYK'); 
imwrite(CMY,'cmy.png');
%% cmy to rgb 
cmy= imread('cmy.png'); 
cmy = im2double(cmy); 
C = cmy(:,:,1); 
M= cmy(:,:,2); 
Y= cmy(:,:,3); 
R=1.-C; 
G=1.-M; 
B=1.-Y; 
RGB1=cat(3,R,G,B); 
subplot(2,3,5), imshow(RGB1), title('RGB'); 
% %% RGB TO YCBCR W/O INBUILT 
RGB = imread('coloured 3D MRI.jpg'); 
r = RGB(:,:,1)/255; 
g = RGB(:,:,2)/255; 
b = RGB(:,:,3)/255; 
Y = 16 + (65.738*r)+ (129.057*g) + (25.064*b); 
Cb = 128 -(37.945*r) - (74.494*g) +(112.439*b); 
Cr = 128 + (112.439*r) - (94.154*g) -(18.285*b); 
YC = cat(3,Y,Cb,Cr);  
subplot(2,3,5), imshow(YC), title('YCbCr'); 
% %% RGB TO YCBCR WITH INBUIT
RGB = imread('Brain.jpg'); 
YCbCr = rgb2ycbcr(RGB);
figure(6); subplot(1,2,1);imshow(RGB);title('RGB Image'); 
subplot(1,2,2);imshow(YCbCr);title('YCbCr Image');
imwrite(YCbCr,'Brain.jpg');
% % %% YCBCR TO RGB WITH INBUILT 
YCBCR=imread('Brain.jpg'); 
RGB1=ycbcr2rgb(YCBCR); 
figure(7); subplot(1,2,1);imshow(YCBCR);
title('YCbCr Image'); subplot(1,2,2);imshow(RGB1);title('RGB Image')