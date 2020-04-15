function [] = PrintCommStatus( CommStatus )
% Print error bit of status packet
global COMM_TXFAIL
global COMM_RXFAIL
global COMM_TXERROR
global COMM_RXWAITING
global COMM_RXTIMEOUT
global COMM_RXCORRUPT

switch(CommStatus)
    case COMM_TXFAIL
        disp('COMM_TXFAIL : Failed transmit instruction packet!');
    case COMM_TXERROR
        disp('COMM_TXERROR: Incorrect instruction packet!');
    case COMM_RXFAIL
        disp('COMM_RXFAIL: Failed get status packet from device!');
    case COMM_RXWAITING
        disp('COMM_RXWAITING: Now recieving status packet!');
    case COMM_RXTIMEOUT
        disp('COMM_RXTIMEOUT: There is no status packet!');
    case COMM_RXCORRUPT
        disp('COMM_RXCORRUPT: Incorrect status packet!');
    otherwise
        disp('This is unknown error code!');
        
end
end