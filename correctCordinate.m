function [coordinate] = correctCordinate(coordinate,R,t)
 
  coordinate(1,1:3)=coordinate(1,1:3)*100;
  coordinate=[coordinate,1];
  trans=[R,t];
  coordinate=coordinate*trans';
  
  coordinate(3)=coordinate(3)-0.6;
  
  coordinate(1,1:3)=coordinate(1,1:3)*10;

end