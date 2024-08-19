im = imread("coloured 3D MRI.jpg");
figure;imshow(im);title("Original image");
d = dct2(im);
figure,imshow(d*0.01);
id =idct2(d);
figure,imshow(id/255);

[r,c] = size(im);
df = zeros(r,c);
dff = df;
idf = df;
idff = df;
depth = 4;
N = 8;

for i = 1:N:r
    for j = 1:N:c
        f = im(i:i+N-1,j:j+N-1);
        DF = dct2(f);
        df(i:i+N-1,j:j+N-1) = DF; %dct of blocks
        DFF = idct2(df);
        dff(i:i+N-1,j:j+N-1) = DFF; %inverse dct of blocks

        DF(N:-1:depth+1,:) = 0;
        DF(:,N-1:depth+1) = 0;
        idf(i:i+N-1,j:j+N-1) = DF; %dct of blocks with depth considered
        dff = idct2(df);
        idff(i:i+N-1,j:j+N-1) = DFF; %inverse dct of blocks with depth considered

    end
end
figure,imshow(df/255);
figure,imshow(dff);
a = dff/255;
figure,imshow(a);
imwrite(a,'abs.jpg');

b = idff/255;
imwrite(b,'abs1.jpg');
figure,imshow(b);