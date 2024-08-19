a=imread('blood smear.jpg');
t = im2bw(imadjust(a(:,:,3)));
se=strel('disk',9);
yy=imdilate(t,se);
se1=strel('disk',3);
yy1=imerode(yy,se1);
jh1=watershed(yy1);
jh2=label2rgb(jh1);

subplot(321);imshow(a),title('Original image');
subplot(322);imshow(t),title('Binary image');
subplot(323);imshow(yy),title('Dilated image');
subplot(324);imshow(yy1),title('Eroded image');
subplot(325);imshow(jh2),title('Segmented image');
figure,imshow(rgb2gray(a)), hold on
himage = imshow(jh2);
set(himage, 'AlphaData', 0.3);
title('Superimposed transparently on original image');
