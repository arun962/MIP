%Feature Extraction
A = imread('tumor.jpg');
A = rgb2gray(A);
binary = binarise(A);
SE=strel('disk',4);
k2=imopen(binary,SE); %image open
b=bwlabel(k2); %colormap
b(b~=4)=0; %connected components of image
k3=imclose(b,strel('disk',18)); %image close
I=k3.*double(A);
X = imcomplement(I);
p = X.*double(A);
% Statistical Features
meanIntensity = mean(I(:));
medianIntensity = median(p(:));
v = var(I(:));

%Textural features
% GLCM
glcms = graycomatrix(I);
glcmaa = graycoprops(glcms);

% Morphological Features
%Area
Area=regionprops(I,'Area');
Area=struct2cell(Area);
Area=cell2mat(Area');
Aveg_Area=mean2(Area);

%Eccentricity
Eccentricity=regionprops(I,'Eccentricity');
Eccentricity=struct2cell(Eccentricity);
Eccentricity=cell2mat(Eccentricity');
Aveg_Eccentricity=mean2(Eccentricity);

%Major Axis Length
MajorAxisLength=regionprops(I,'MajorAxisLength');
MajorAxisLength=struct2cell(MajorAxisLength);
MajorAxisLength=cell2mat(MajorAxisLength');
Aveg_MajorAxisLength=mean2(MajorAxisLength);

%Minor Axis Length
MinorAxisLength=regionprops(I,'MinorAxisLength');
MinorAxisLength=struct2cell(MinorAxisLength);
MinorAxisLength=cell2mat(MinorAxisLength');
Aveg_MinorAxisLength=mean2(MinorAxisLength);

%Perimeter
Perimeter=regionprops(I,'Perimeter');
Perimeter=struct2cell(Perimeter);
Perimeter=cell2mat(Perimeter');
Aveg_Perimeter=mean2(Perimeter);

figure(1);
subplot(321);imshow(A);title('Original Image');
subplot(322);imshow(k2); title('Opened Image');
subplot(323);imshow(b,[]); title('Colourmap Image');
subplot(324);imshow(b); title('Image with connected component');
subplot(325);imshow(k3); title('Image after closing');
subplot(326);imshow(I,[]); title('Segmented Image');


disp("Mean intensity"); disp(meanIntensity);
disp("Median intensity"); disp(medianIntensity);
disp("Variance"); disp(v);

disp("Area"); disp(Aveg_Area);
disp("Eccentricity"); disp(Aveg_Eccentricity);
disp("Maajor axis length"); disp(Aveg_MajorAxisLength);
disp("Minor axis length"); disp(Aveg_MinorAxisLength);
disp("perimeter"); disp(Aveg_Perimeter);

function binary = binarise(A)
[x, y]=size(A);
a=double(A);
sum=0;
for i=1:x
    for j=1:y
        sum=sum+a(i,j);
    end
end
threshold=sum/(0.85*x*y);
binary=zeros(x,y);
for i=1:x
    for j=1:y
        if a(i,j)>=threshold
            binary(i,j)=0;
        else
            binary(i,j)=1;
        end
    end
end
end
