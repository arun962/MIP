i = imread("corneal view.jpg");
i = im2bw(i);
[r,c] = size(i);
i = padarray(i,[1,1],0,'both');
dil = dilation(i,r,c);
subplot(131);
imshow(i);title("input image");
subplot(132);
imshow(dil,[]);title("Dilated image");
ero = erosion(i,r,c);
subplot(133);
imshow(ero,[]);title("Eroded image");
%%
function y = pixel_dist(x1,y1,x2,y2)
y = sqrt((x1-x2)^2 + (y1-y2)^2);
end

function x = circ(n)
x = zeros(n);
for i =1:n
    for j = 1:n
        D = pixel_dist(i,j,round(n/2),round(n/2));
        if D<Do
            x(i,j) = 1;
        else
            x(i,j) = 0;
        end
    end
end
end

function x = dilation(im,r,c)
x = zeros(r,c);
for j = 1:r
    for k = 1:c
        x(j,k) = max(im(j,k:k+2));
end
end
end

function x = erosion(im,r,c)
x = zeros(r,c);
for j = 1:r
    for k = 1:c
        x(j,k) = min(im(j,k:k+2));
end
end
end

