orginal = imread('lena_dark.png');
[rows,columns,~] = size(orginal);
finalResult = uint8(zeros(rows,columns));
pixelNumber = rows*columns;
frequncy = zeros(256,1);
pdf = zeros(256,1);
cdf = zeros(256,1);
cummlative = zeros(256,1);
outpic = zeros(256,1);
for i = 1:1:rows
    for j = 1:1:columns
        val = orginal(i,j);
        frequncy(val+1) = frequncy(val+1)+1;
        pdf(val+1) = frequncy(val+1)/pixelNumber;
    end
end
sum =0 ;
intensityLevel = 255;
for i = 1:1:size(pdf)
    sum =sum +frequncy(i);
    cummlative(i) = sum;
    cdf(i) = cummlative(i)/ pixelNumber;
    outpic(i) = round(cdf(i) * intensityLevel);
end

for i = 1:1:rows
    for j = 1:1:columns
        finalResult(i,j) = outpic(orginal(i,j) + 1);
    end
end
subplot(1,2,1),imshow(finalResult),title('manual histeq');
subplot(1,2,2),imshow(orginal),title('original');
figure(2);
imhist(finalResult);