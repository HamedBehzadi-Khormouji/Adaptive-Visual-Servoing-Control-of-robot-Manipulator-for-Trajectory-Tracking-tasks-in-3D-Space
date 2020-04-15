function [val, error] = runReadCommand(funcName,id,tblAddress,pos)
error = 0;
global COMM_RXSUCCESS;
val = calllib('dynamixel2_win64',funcName,id,tblAddress);
% CommStatus = int32(calllib('dynamixels2_win32','dxl_get_comm_result'));%noise
% if CommStatus == COMM_RXSUCCESS
%     PrintErrorCode();
% else
%     val = calllib('dynamixel2_win32',funcName,id,tblAddress,pos);
%     CommStatus = int32(calllib('dynamixels2_win32','dxl_get_comm_result'));%noise
%     if CommStatus == COMM_RXSUCCESS
%         PrintErrorCode();
%     else
%         PrintCommStatus(CommStatus);
%         error = 1;
%     end
% end
end