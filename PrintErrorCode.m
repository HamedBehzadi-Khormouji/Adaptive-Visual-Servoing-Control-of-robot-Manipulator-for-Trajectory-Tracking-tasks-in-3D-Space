function [] = PrintErrorCode()
global ERRBIT_VOLTAGE
global ERRBIT_ANGLE 
global ERRBIT_OVERHEAT
global ERRBIT_RANGE
global ERRBIT_CHECKSUM
global ERRBIT_OVERLOAD
global ERRBIT_INSTRUCTION
%Print commuication result
 if int32(calllib('dynamixel2_win64','dxl_get_rxpacket_error', ERRBIT_VOLTAGE))==1
     disp('Input Voltage Error!');
 elseif int32(calllib('dynamixel2_win64','dxl_get_rxpacket_error',ERRBIT_ANGLE))==1
     disp('Angle limit error!');
 elseif int32(calllib('dynamixel2_win64','dxl_get_rxpacket_error',ERRBIT_OVERHEAT))==1
     disp('Overheat error!');
 elseif int32(calllib('dynamixel2_win64','dxl_get_rxpacket_error',ERRBIT_RANGE))==1
     disp('Out of range error!');
 elseif int32(calllib('dynamixel2_win64','dxl_get_rxpacket_error',ERRBIT_CHECKSUM))==1
     disp('Checksum error!');
 elseif int32(calllib('dynamixel2_win64','dxl_get_rxpacket_error',ERRBIT_OVERLOAD))==1
     disp('Overload error!');
 elseif int32(calllib('dynamixel2_win64','dxl_get_rxpacket_error',ERRBIT_INSTRUCTION))==1
     disp('Instruction code error!');
 end