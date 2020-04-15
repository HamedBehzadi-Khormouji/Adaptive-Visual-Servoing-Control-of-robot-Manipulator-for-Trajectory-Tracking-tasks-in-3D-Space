function [] = goToPosition(id,pos)
global P_GOAL_POSITION;
global P_PRESENT_POSITION;
global COMM_RXSUCCESS
global P_Moving;
error = 0;
%calllib('dynamixel2_win64','dxl2_write_word',id,P_GOAL_POSITION,pos);
%calllib('dynamixel2_win64','dxl_write_word',1,P_GOAL_POSITION,pos); 
error = runWriteCommand('dxl_write_word',id,P_GOAL_POSITION,pos);
%error = runWriteCommand('dxl_write_word',id,P_GOAL_POSITION,pos);
PrintErrorCode();
if error == 1
    return
end
Moving = 1;
send_count = 1;
while Moving == 1
    %Read Present position
    [PresentPos,error] = runReadCommand('dxl_read_word',id,P_PRESENT_POSITION);
    CommStatus = int32(calllib('dynamixel2_win64','dxl_get_comm_result'));%noise
    if CommStatus == COMM_RXSUCCESS
        PrintErrorCode();
    else
        PrintCommStatus(CommStatus);
        break;
    end
    if error == 1
        return;
    end
%     Position =['send pos' pos 'real pos' PresentPos];
%     disp(Position);
    %Check moving done
    [Moving,error] = runReadCommand('dxl_read_word',id,Moving);
    if error == 1
        return;
    end
end
end