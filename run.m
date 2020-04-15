
%{
data=[];
temp=[];
trans=RigidTrans;
R=trans(:,1:3);
t=trans(:,4);
[EE,Desired]=move(PointList,reducedxyzPoints,R,t,colorDevice,depthDevice);
data=[data;EE,Desired]
RLSE(data,landa)
save ('data','data')
%% LSE
EE=data(1:end,1:3)
Desired=data(1:end,4:6)
theta=LSE(EE,Desired);
save theta
%% RLSE
[r,~]=size(EE);
EE=EE*100;
Desired=Desired/10;
theta=[];
out=[];
desired=[];
for i=1:r
    out=[out;EE(i,1:3),1];
    desired=[desired;Desired(i,1:3)];
    theta=RLSE(out,desired,I);
end
%%

%load trans
%RR=trans(1:3,1:3)
%tt=trans(1:3,4)
RR=Theta(1:3,1:3)
tt=Theta(1:3,4)
[EE,Desired]=move(PointList,reducedxyzPoints,RR,tt,colorDevice,depthDevice);
data=[data;EE,Desired]
theta=RLSE(data,landa);
RR=theta(1:3,1:3);
tt=theta(1:3,4);
Theta=[RR,tt]
save('RLSETheta','Theta')
%}

%% Kinect Model
[colorDevice,depthDevice]=kinectModel();

%% Initial
landa=0.9;
counter=1;
initialPoint=[500;855;464;786];
load('initial_data.mat')

load('RLSETheta.mat')
RR=Theta(1:3,1:3);
tt=Theta(1:3,4);

%% Points of trajectory
[PointList,reducedxyzPoints,reducedcolorImage]=getPicture(colorDevice,depthDevice);
pixels=PointList;

cp=70:3:110;
[~,ss]=size(cp);
rp=ones(1,ss);
for iii=1:ss
    rp(iii)=61;
end
cp=[cp,113,116];
rp=[rp,62,62];
pixels=[rp',cp'];
%}

[r,~]=size(pixels);
dataplot=[];
dataplotR=[];
%% Tune to the initial point
initial()
while (counter<=3)
    [EE,Desired,coor2,x_c,y_c,z_c]=move(pixels(1,1),pixels(1,2),reducedxyzPoints,RR,tt,colorDevice,depthDevice);
    data=[data;EE,Desired];
    Theta=RLSE(data,landa);
    RR=Theta(1:3,1:3);
    tt=Theta(1:3,4);
    goToPosition(4,initialPoint(3));
    pause(2)
    goToPosition(1,initialPoint(1));
    goToPosition(5,initialPoint(4));
    goToPosition(2,initialPoint(2));
    goToPosition(3,1024-initialPoint(2));
    counter=counter+1;
    pause
end

for i=1:r
    [EE,Desired,coor2,x_c,y_c,z_c]=move(pixels(i,1),pixels(i,2),reducedxyzPoints,RR,tt,colorDevice,depthDevice);
    if isempty(EE)==1
    else
         dataplot=[dataplot;EE,x_c,y_c,z_c];
         dataplotR=[dataplotR;coor2,Desired];
    end
   
    %data=[data;EE,Desired];
    %Theta=RLSE(data,landa);
    %RR=Theta(1:3,1:3);
    %tt=Theta(1:3,4);
end
%% Back to the initial point
goToPosition(4,initialPoint(3));
pause(2)
goToPosition(1,initialPoint(1));
goToPosition(5,initialPoint(4));
goToPosition(2,initialPoint(2));
goToPosition(3,1024-initialPoint(2));



[r,c]=size(dataplot);
dataplot=dataplot(1:end,1:end)*100;
e=0;
e=dataplot(1:end,4:6)-dataplot(1:end,1:3);
e=e.*e;
e=sum(e,2);
e=sqrt(e);
AVGDist=sum(e)/r


e=0;
e=dataplot(1:end,4:6)-dataplot(1:end,1:3);
e=e.*e;
e=sum(e,2);
e=sqrt(e);
e=e.*e;
e=sum(e);
e=e/r;
RootMeanSquare=sqrt(e)


e=0;
e=dataplot(1:end,4)-dataplot(1:end,1);
e=e.*e;
e=sum(e);
EX=sqrt(e/r)

e=0;
e=dataplot(1:end,5)-dataplot(1:end,2);
e=e.*e;
e=sum(e);
EY=sqrt(e/r)



e=0;
e=dataplot(1:end,6)-dataplot(1:end,3);
e=e.*e;
e=sum(e);
EZ=sqrt(e/r)

