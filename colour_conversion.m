A=imread('coloured 3D MRI.jpg');
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

