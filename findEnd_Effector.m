function []= findEnd_Effector(colorDevice,depthDevice)

colorImage = getsnapshot(colorDevice);
depthImage = getsnapshot(depthDevice);
[depthImage, zeroPixels] = Kinect_DepthNormalization(depthImage);
[colorImage, depthImage] = alignColorToDepth(depthImage, colorImage, depthDevice);
xyzPoints = depthToPointCloud(depthImage,depthDevice);
%imtool(colorImage)
xyzPoints = swap_YZ(xyzPoints);
reducedxyzPoints=xyzPoints((480-280+1):(480-202+1),(640-359+1):(640-230+1),:);
reducedcolorImage=colorImage(202:280,230:359,:);

h=[1/9 1/9 1/9
    1/9 1/9 1/9
    1/9 1/9 1/9];
filteredRGB = imfilter(reducedcolorImage,h);
imtool(filteredRGB)
[r,c]=find(filteredRGB(:,:,1)<=60 & filteredRGB(:,:,2)>=100 & filteredRGB(:,:,2)<=118 & filteredRGB(:,:,3)<=70)
filteredRGB(r(1),c(1),2)=255;
imtool(filteredRGB)

end