A = imread("coloured 3D MRI.jpg");
A1 = rgb2gray(A);


%% 

%2D DFT
wM =zeros(m,m);
wN = zeros(n,n);

for u=0:m-1
    for v = 0:m-1
        wM(u+1,v+1) = exp(-2*1i*pi*u*v/m);
    end
end

for x = 0:n-1
    for y = 0:n-1
        wN(x+1,y+1) = exp(-2*1i*pi*x*y/n);
    end
end
DFT2 = wM*im2double(A2)*wN;
figure,
subplot(131);imshow(A);title("Original Image");
subplot(132);imshow(abs(DFT2));title("2D-DFT of an image");
subplot(133);imshow(abs(N));title("2D-DCT of an image");

