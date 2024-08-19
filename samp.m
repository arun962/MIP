I=imread('Brain.jpg');
A = rgb2gray(I);
[m,n]=size(A);
M = zeros(m,m);
N = zeros(n,n);
for i=1:m
    for j = 1: n
        if(i==1)
            alphaP=sqrt(1/m);
        else
            alphaP=sqrt(2/m);
        end
        if(j==1)
            alphaQ=sqrt(1/n);
        else
            alphaQ=sqrt(2/n);
        end
    end
end
for u = 0:m-1
    for x = 0:m-1
        M(u+1, x+1) = cos(pi*u*(2*x+1)/(2*m));
    end
end
for v = 0:n-1
    for y = 0:n-1
        N(v+1, y+1) =cos(pi*v*(2*y+1)/(2*n)) ;
    end
end
F = M* im2double(A)*N;
B= alphaP*alphaQ*F;
subplot(3,2,1);
imshow(I);title('original image')
subplot(3,2,2);
imshow(A);title('Grayscale img');
subplot(3,2,3);
imshow(mat2gray(log(1+abs(B))));title('2D Dct img without inbuilt')
G = inv(M)* im2double(B)*inv(N);
subplot(3,2,5);
imshow(mat2gray(log(1+abs(G))));title("2D- IDCT without inbuilt");
B= dct2(A);
subplot(3,2,4);
imshow(mat2gray(log(1+abs(B)))); title("2D- DCT with inbuilt");
C1=idct2(B);
subplot(3,2,6);
imshow(mat2gray(abs(C1)));title('2D- IDCT with inbuilt');