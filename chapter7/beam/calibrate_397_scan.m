% 397 calibration data, 2nd August 2007
d = [
0 270;
2500 319
-2500 217
1500 300
-1500 237
1000 289
-1000 247
0 267];

x = d(:,1); y=d(:,2);
p = polyfit(x,y,1);
plot(x,y,'.', [min(x) max(x)], p(1)*[min(x) max(x)]+p(2))
disp(p)
d(2:3,:) = [];
x = d(:,1); y=d(:,2);
disp( polyfit(x,y,1) );
