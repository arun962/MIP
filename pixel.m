h = imread("MRI Brain Gray.jpg");
imshow(h);
coordinates_input = ginput(2)
x1 = round(coordinates_input(1));
y1 = round(coordinates_input(3));
x2 = round(coordinates_input(2));
y2 = round(coordinates_input(4));
E = sqrt((x1-x2)^2+(y1-y2)^2);
Ci = abs(x1-x2) + abs(y1-y2);
Ch = max(abs(x1-x2),abs(y1-y2));
fprintf("Euclidian distance between (%d,%d) & (%d,%d) is %2.4f\n",x1,y1,x2,y2,E);
fprintf("Cityblock distance between (%d,%d) & (%d,%d) is %2.4f\n",x1,y1,x2,y2,Ci);
fprintf("Chessboard distance between (%d,%d) & (%d,%d) is %2.4f\n",x1,y1,x2,y2,Ch);

