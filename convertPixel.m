function [x_c,y_c,z_c] =convertPixel(x,y,xyz)

%row=480-x+1%x=row
%col=640-y+1%y=column
%XYZ=xyz(row,col,:);
%coordinate=[XYZ(1,1,1),XYZ(1,1,2),XYZ(1,1,3)]


row=79-x+1;%x=row
col=130-y+1;%y=column
XYZ=xyz(row,col,:);
x_c=XYZ(1,1,1);
y_c=XYZ(1,1,2);
z_c=XYZ(1,1,3);
end