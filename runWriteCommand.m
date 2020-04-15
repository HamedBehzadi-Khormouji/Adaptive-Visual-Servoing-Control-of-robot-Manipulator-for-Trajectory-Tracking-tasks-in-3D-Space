function error = runWriteCommand(funcName,id,tblAddress,pos)
global COMM_RXSUCCESS;

calllib('dynamixel2_win64',funcName,id,tblAddress,pos);
error = 0;
% CommStatus = int32(calllib('dynamixels2_win32','dxl_get_comm_result'));%noise
% if CommStatus == COMM_RXSUCCESS
%     PrintErrorCode();
% else
%     calllib('dynamixel2_win32',funcName,id,tblAddress,pos);
%     CommStatus = int32(calllib('dynamixels2_win32','dxl_get_comm_result'));%noise
%     if CommStatus == COMM_RXSUCCESS
%         PrintErrorCode();
%     else
%         PrintCommStatus(CommStatus);
%         error = 1;
%     end
% end
end