clc;
clear all;
close all;
A=imread("coloured 3D MRI.jpg");
I=double(A)/255;
% Conversion of RGB to HSI
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
%H calculation
numi=1/2*((R-G)+(R-B));
denom=((R-G).^2+((R-B).*(G-B))).^0.5;
H=acosd(numi./(denom+0.000001));
H(B>G)=360-H(B>G);%If B>G then H= 360-Theta
H=H/360;
%Saturation
S=1- (3./(sum(I,3)+0.000001)).*min(I,[],3);
%Intensity
I=sum(I,3)./3;
%HSI
HSI=zeros(size(A));
HSI(:,:,1)=H;
HSI(:,:,2)=S;
HSI(:,:,3)=I;
subplot(334);imshow(A);title('RGB Image');
subplot(332);imshow(HSI);title('HSI Image');
% HSI to RGB Conversion
H=H*360;
R1=zeros(size(H));
G1=zeros(size(H));
B1=zeros(size(H));
%RG Sector(0<=H<120)
B1(H<120)=I(H<120).*(1-S(H<120));  
R1(H<120)=I(H<120).*(1+((S(H<120).*cosd(H(H<120)))./cosd(60-H(H<120))));  
G1(H<120)=3.*I(H<120)-(R1(H<120)+B1(H<120));
%GB Sector(120<=H<240)
H2=H-120;
R1(H>=120&H<240)=I(H>=120&H<240).*(1-S(H>=120&H<240));  
G1(H>=120&H<240)=I(H>=120&H<240).*(1+((S(H>=120&H<240).*cosd(H2(H>=120&H<240)))./cosd(60-H2(H>=120&H<240))));  
B1(H>=120&H<240)=3.*I(H>=120&H<240)-(R1(H>=120&H<240)+G1(H>=120&H<240));
%BR Sector(240<=H<=360)
H2=H-240;  
G1(H>=240&H<=360)=I(H>=240&H<=360).*(1-S(H>=240&H<=360));  
B1(H>=240&H<=360)=I(H>=240&H<=360).*(1+((S(H>=240&H<=360).*cosd(H2(H>=240&H<=360)))./cosd(60-H2(H>=240&H<=360))));  
R1(H>=240&H<=360)=3.*I(H>=240&H<=360)-(G1(H>=240&H<=360)+B1(H>=240&H<=360));
% Form RGB image
RGB1=zeros(size(HSI));
RGB1(:,:,1)=R1;  
RGB1(:,:,2)=G1;  
RGB1(:,:,3)=B1;
subplot(333);imshow(RGB1);title('HSI to RGB');
% RGB to YCbCr
[m,n,d]=size(A);
Y = (0.299*R) + (0.587*G) + (0.114*B) + 0;
Cb = (-0.168736*R) + (-0.331264*G) + (0.5*B) + 0.5;
Cr = (0.5*R) + (-0.418688*G) - (0.081312*B) + 0.5;
YCbCr=zeros(size(A));
YCbCr(:,:,1)=Y;
YCbCr(:,:,2)=Cb;
YCbCr(:,:,3)=Cr;
subplot(335);imshow(YCbCr);title('YCbCr Image');
% YCbCr to RGB
new_R = Y + (1.402*(Cr-0.5));
new_G = Y-(0.34414*(Cb-0.5))-(0.71414*(Cr-0.5));
new_B = Y+(1.772*(Cb-0.5));
RGB2=zeros(size(YCbCr));
RGB2(:,:,1)=new_R;
RGB2(:,:,2)=new_G;
RGB2(:,:,3)=new_B;
subplot(336);imshow(RGB2);title('YCbCr to RGB');
% RGB to CMYK
C=1.-R;
M=1.-G;
Y=1.-B;
CMY=cat(3,C,M,Y);
subplot(338);imshow(CMY);title('CMYK Image');
% CMYK to RGB
CMY=double(CMY);
c=CMY(:,:,1);
m=CMY(:,:,2);
y=CMY(:,:,3);
newR=1.-c;
newG=1.-m;
newB=1.-y;
newRGB=cat(3,newR,newG,newB);
subplot(339);imshow(newRGB);title('CMYK to RGB');
B1(H1>=120&H1<240)=3.*I1(H1>=120&H1<240)-
(R1(H1>=120&H1<240)+G1(H1>=120&H1<240));
%BR Sector(240<=H<=360)
%When H is in the above sector, the RGB components equations are
%Subtract 240 from Hue
H2=H1-240;
G1(H1>=240&H1<=360)=I1(H1>=240&H1<=360).*(1-S1(H1>=240&H1<=360));
B1(H1>=240&H1<=360)=I1(H1>=240&H1<=360).*(1+((S1(H1>=240&H1<=360).*c
osd(H2(H1>=240&H1<=360)))./cosd(60-H2(H1>=240&H1<=360))));
R1(H1>=240&H1<=360)=3.*I1(H1>=240&H1<=360)-
(G1(H1>=240&H1<=360)+B1(H1>=240&H1<=360));
%Form RGB Image
RGB1(:,:,1)=R1;
RGB1(:,:,2)=G1;
RGB1(:,:,3)=B1;
%Represent the image in the range [0 255]
RGB1=im2uint8(RGB1);
subplot(1,2,2);imshow(RGB1);title('RGB Image');
%% RGB TO CMY W/O INBUILT
RGB = imread('colormri.jpg');
RGB = im2double(RGB);
R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);
C=1.-R;
M=1.-G;
Y=1.-B;
CMY=cat(3,C,M,Y);
figure(3),subplot(2,3,1);imshow(RGB);title('RGB Image');
subplot(2,3,2),imshow(C), title('Cyan');
subplot(2,3,3), imshow(M), title('Magenta');
subplot(2,3,4), imshow(Y), title('Yellow');
subplot(2,3,5), imshow(CMY), title('CMYK');
imwrite(CMY,'cmy.jpg');
%% cmy to rgb
cmy= imread('cmy.jpg');
cmy = im2double(cmy);
C = cmy(:,:,1);
M= cmy(:,:,2);
Y= cmy(:,:,3);
R=1.-C;
G=1.-M;
B=1.-Y;
RGB1=cat(3,R,G,B);
figure(4); subplot(2,3,1);imshow(cmy);title('CMY Image');
subplot(2,3,2),imshow(R), title('Red');
subplot(2,3,3), imshow(G), title('Green');
subplot(2,3,4), imshow(B), title('Blue');
subplot(2,3,5), imshow(RGB1), title('RGB');
% %% RGB TO YCBCR W/O INBUILT
RGB = imread('colormri.jpg');
r = RGB(:,:,1)/255;
g = RGB(:,:,2)/255;
b = RGB(:,:,3)/255;
Y = 16 + (65.738*r)+ (129.057*g) + (25.064*b);
Cb = 128 -(37.945*r) - (74.494*g) +(112.439*b);
Cr = 128 + (112.439*r) - (94.154*g) -(18.285*b);
YC = cat(3,Y,Cb,Cr);
figure(5); subplot(2,3,1),imshow(RGB);title('RGB Image');
subplot(2,3,2),imshow(Y), title('Y');
subplot(2,3,3), imshow(Cb), title('Cb');
subplot(2,3,4), imshow(Cr), title('Cr');
subplot(2,3,5), imshow(YC), title('YCbCr');
% %% RGB TO YCBCR WITH INBUIT
RGB = imread('colormri.jpg');
YCbCr = rgb2ycbcr(RGB);
figure(6); subplot(1,2,1);imshow(RGB);title('RGB Image');
subplot(1,2,2);imshow(YCbCr);title('YCbCr Image');
imwrite(YCbCr,'ycbcr.png');
% % %% YCBCR TO RGB WITH INBUILT
YCBCR=imread('ycbcr.png');
RGB1=ycbcr2rgb(YCBCR);
figure(7); subplot(1,2,1);imshow(YCBCR);
title('YCbCr Image'); subplot(1,2,2);imshow(RGB1);
title('RGB Image');