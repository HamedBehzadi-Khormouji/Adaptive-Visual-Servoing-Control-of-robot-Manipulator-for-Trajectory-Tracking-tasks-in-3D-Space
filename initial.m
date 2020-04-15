function [] = initial()
clear all;
close all;
%% Initial Values
global ERRBIT_VOLTAGE
ERRBIT_VOLTAGE     = 1;
global ERRBIT_ANGLE
ERRBIT_ANGLE       = 2;
global ERRBIT_OVERHEAT
ERRBIT_OVERHEAT    = 4;
global ERRBIT_RANGE
ERRBIT_RANGE       = 8;
global ERRBIT_CHECKSUM
ERRBIT_CHECKSUM    = 16;
global ERRBIT_OVERLOAD
ERRBIT_OVERLOAD    = 32;
global ERRBIT_INSTRUCTION
ERRBIT_INSTRUCTION = 64;

global COMM_TXSUCCESS
COMM_TXSUCCESS     = 0;
global COMM_RXSUCCESS
COMM_RXSUCCESS     = 1;
global COMM_TXFAIL
COMM_TXFAIL        = 2;
global COMM_RXFAIL
COMM_RXFAIL        = 3;
global COMM_TXERROR
COMM_TXERROR       = 4;
global COMM_RXWAITING
COMM_RXWAITING     = 5;
global COMM_RXTIMEOUT
COMM_RXTIMEOUT     = 6;
global COMM_RXCORRUPT
COMM_RXCORRUPT     = 7;
global P_GOAL_POSITION;
P_GOAL_POSITION = 30;
global P_PRESENT_POSITION;
P_PRESENT_POSITION = 36;

positionLimit = [597 3313
    612 3203
    627 3038
    642 2983
    657 2928
    672 2873
    687 2763
    702 2653
    717 2653
    732 2543
    747 2433
    762 2378
    777 2323
    792 2213
    807 2158];
DEFAULT_PORTNUM = 4; % com3
DEFAULT_BAUDNUM = 1; % 1mbps
global P_Moving ;
P_Moving = 46;
index = 1;
%% connect to webcam
% camera = videoinput('winvideo',1);
% preview(camera);
%% load library and initial connection
% imaqreset
%
% colorDevice = videoinput('kinect',1);
% depthDevice = videoinput('kinect',2);

loadlibrary('dynamixel2_win64','dynamixel2.h');
res = calllib('dynamixel2_win64','dxl_initialize',DEFAULT_PORTNUM,1000000);
speed = 30;
if res == 1
    disp('Succeed to open USB2Dynamixel!');
    calllib('dynamixel2_win64','dxl_write_word',1,32,speed);
   
    calllib('dynamixel2_win64','dxl_write_word',2,32,speed);
   
    calllib('dynamixel2_win64','dxl_write_word',3,32,speed);
   
    calllib('dynamixel2_win64','dxl_write_word',4,32,speed);%motornumber,address,speed
  
    calllib('dynamixel2_win64','dxl_write_word',5,32,speed);
   
    calllib('dynamixel2_win64','dxl2_write_word',7,32,speed);
   
    calllib('dynamixel2_win64','dxl2_write_word',8,32,speed);
    
else
    disp('Failed to open USB2Dynamixel!');
    return;
end

end