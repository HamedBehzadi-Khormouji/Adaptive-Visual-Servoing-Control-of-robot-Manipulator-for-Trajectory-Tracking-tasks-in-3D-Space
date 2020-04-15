function [EE,Desired,coor2,x_c,y_c,z_c] = move(row,col,xyzPoints,R,t,colorDevice,depthDevice)

    EE=[];
    Desired=[];
    coor2=[];
    [x_c,y_c,z_c]=convertPixel(row,col,xyzPoints);
    coordinate=[x_c,y_c,z_c];
    coordinate=correctCordinate(coordinate,R,t);
    
    tt=ikv3(coordinate);
    %angle=ConvertAngle(tt);
    angle=ConvertAngle_2(tt);
    goToPosition(1,angle(1));
    %pause
    goToPosition(5,angle(5));
    %pause
    goToPosition(4,angle(4));
    %pause
    goToPosition(2,angle(2));
    goToPosition(3,angle(3));
    pause
    ttt(1,1)=getPosition(1);
    ttt(1,2)=getPosition(2);
    ttt(1,3)=getPosition(4);
    ttt(1,4)=getPosition(5);
    an=iconvertAngle(ttt);
    [x,y,z]=fkv2(an);
    
    [PointList,reducedxyzPoints,reducedcolorImage]=getPicture2(colorDevice,depthDevice);
    filter=[1/9 1/9 1/9;1/9 1/9 1/9;1/9 1/9 1/9];
    fimg2 = imfilter(reducedcolorImage,filter); 
    
    [r,c,k]=size(fimg2);
    rr=[];
    cc=[];
    for i=1:r
        for j=1:c
            if (fimg2(i,j,1)>=10 & fimg2(i,j,1)<=35 & fimg2(i,j,2)>=10 & fimg2(i,j,2)<=30 & fimg2(i,j,3)>=110 & fimg2(i,j,3)<=160)
                rr=[rr;i];
                cc=[cc;j];
            end
        end
    end
   if size(rr,1)~=0
    Desired=[Desired;coordinate(1),coordinate(2),coordinate(3)];
    %{
    eimg2=fimg2;
    eimg2(rr(1),cc(1),1)=0;
    eimg2(rr(1),cc(1),2)=0;
    eimg2(rr(1),cc(1),3)=255;
    imtool(eimg2)
    %}
    [x1_c,y1_c,z1_c]=convertPixel(rr(1),cc(1),reducedxyzPoints);
    EE=[x1_c,y1_c,z1_c]
    coor2=correctCordinate(EE,R,t);
   end
   
end
