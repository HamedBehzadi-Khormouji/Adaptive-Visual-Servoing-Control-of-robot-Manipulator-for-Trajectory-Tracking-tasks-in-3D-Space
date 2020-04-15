function [colorDevice,depthDevice]=kinectModel()
colorDevice = videoinput('kinect',1);
depthDevice = videoinput('kinect',2);
triggerconfig(colorDevice, 'manual');
start(colorDevice);
triggerconfig(depthDevice, 'manual');
start(depthDevice);
pause(2);
return
colorImage = getsnapshot(colorDevice);
depthImage = getsnapshot(depthDevice);
[depthImage, zeroPixels] = Kinect_DepthNormalization(depthImage);
[colorImage, depthImage] = alignColorToDepth(depthImage, colorImage, depthDevice);
xyzPoints = depthToPointCloud(depthImage,depthDevice);
xyzPoints = swap_YZ(xyzPoints);

imtool(colorImage);
move(xyzPoints)
%figure
imtool(depthImage,[]);
size(xyzPoints)
pcshow(xyzPoints,'VerticalAxis','y','VerticalAxisDir','down');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
imwrite(colorImage,'colorimg.png');
%csvwrite('k3.csv',xyzPoints)
%
points=reshape(xyzPoints,size(xyzPoints,1)*size(xyzPoints,2),3);
rgb0 = reshape(colorImage,size(points,1),3);
rgb0=double(rgb0);
pointU =[points rgb0];
csvwrite('k2.csv',pointU);


return

return
% load library and initial connection
close all
initial();
calllib('dynamixel2_win64','dxl2_write_word',6,25,1);
% goToPosition(1,330);
% pause
% goToPosition(2,542);
% goToPosition(3,1024 - 542);
% pause
% goToPosition(4,3258);
% pause
imaqreset
colorDevice = videoinput('kinect',1);
depthDevice = videoinput('kinect',2);

colorImage = getsnapshot(colorDevice);
imshow(colorImage);
Temp = (colorImage(:,:,1)>= 160 & colorImage(:,:,2)<=55);
figure

t1 = imerode(Temp ,[0 1 0;0 1 0;0 1 0]);
t2 = imerode(Temp ,[0 0 0;1 1 1;0 0 0]);
t3 = imerode(Temp ,[0 0 1;0 1 0;1 0 0]);
t4 = imerode(Temp ,[1 0 0;0 1 0;0 0 1]);
tf = t1+t2+t3+t4;
Temp = tf;
%         imtool(Temp); 
depthImage = getsnapshot(depthDevice);
imshow(depthImage,[]);
[x y] =find(Temp == 1);
EndLocationX = median(x)
EndLocationY = median(y)
d = [];
cq = 1;
 [m n] = size(x);
if(m == 0)
    disp('======================no depth=============================');
end
for i = 1:m
    if depthImage(x(i),y(i)) ~= 0
        d(cq) = depthImage(x(i),y(i));
        cq = cq + 1;
    end
end
EndDepth = mean(d)


