function [angle] = iconvertAngle(theta)

angle=zeros(1,4);
    for i=1:4
        if i==1
            theta(i)=(theta(i)*300)/1024;
            angle(1)=theta(i) - 150 ;
            

        elseif i==2
            theta(i)=(theta(i)*300)/1024;
            angle(2)=-1*(theta(i) - 240) ;
            
        elseif i==3
            theta(i)=(theta(i)*360)/4096;
             angle(3)=-1*(theta(i)-180) ;
            
        elseif i==4
            theta(i)=(theta(i)*300)/1024;
            angle(4)=-1*(theta(i)-150) ;
            
        end
    end
end