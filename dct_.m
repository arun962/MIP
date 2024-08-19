im = imread("Brain.jpg");
im = rgb2gray(im);
im1 = double(im);
[M,N] = size(im1);
m = zeros(M,M);
n = zeros(N,N);
%dct
for u = 1:M
    for v=1:N
        if u ==1
            cu = sqrt(1/M);
        else
            cu = sqrt(2/M);
        end
        if v ==1
            cv = sqrt(1/N);
        else
            cv = sqrt(2/N);
        end
    end
end
for x = 0:M-1
    for y = 0:M-1
       m(x+1,y+1) = cos(pi*x*(2*y+1)/2*M);
    end
end
for i = 0:N-1
    for j = 0:N-1
        n(i+1,j+1) = cos(pi*i*(2*j+1)/(2*N));
    end
end
dc = m*im1*n;
dc2 = cu*cv*dc;
subplot(321);
imshow(im);title("Original Image");
subplot(323);
imshow(mat2gray(log(1+abs(dc2))));title("2D-DCT without in-built");
subplot(324);
imshow(mat2gray(log(1+abs(dct2(im1)))));title("2D-DCT with inbuilt");
subplot(325);
idc = idct2(dc2);
imshow(mat2gray(abs(idc)));title("IDCT image");
subplot(326);
imshow(mat2gray(abs(idct2(dct2(im1)))));title('IDCT with inbuilt');