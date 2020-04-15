function[PointList,reducedxyzPoints,reducedcolorImage]= getPicture(colorDevice,depthDevice)

colorImage = getsnapshot(colorDevice);
depthImage = getsnapshot(depthDevice);
[depthImage, zeroPixels] = Kinect_DepthNormalization(depthImage);
[colorImage, depthImage] = alignColorToDepth(depthImage, colorImage, depthDevice);
xyzPoints = depthToPointCloud(depthImage,depthDevice);
xyzPoints = swap_YZ(xyzPoints);

reducedxyzPoints=xyzPoints((480-280+1):(480-202+1),(640-359+1):(640-230+1),:);
reducedcolorImage=colorImage(202:280,230:359,:);

%filter=[1/9 1/9 1/9;1/9 1/9 1/9;1/9 1/9 1/9];
%fimg2 = imfilter(reducedcolorImage,filter); 

imtool(reducedcolorImage)
I = rgb2gray( reducedcolorImage);
BW = edge(I,'canny',[0.3,0.65]);%
imtool(BW);
[xpath,ypath]=find(BW==1);
BW(1:13,61:79)=0;
[PointList]=getPoints(BW);
PointList(1,1)=PointList(1,1)+1;
PointList(2:end-1,1)=PointList(2:end-1,1)+2;
%PointList(end,1)=PointList(end,1)+1;

PointList=PointList(1:3:end,:);
%PointList=DouglasPeucker([PointList(:,1)';PointList(:,2)'],0.01,false);
end