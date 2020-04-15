function [angle] = ConvertAngle_2(theta)
    angle=zeros(1,5);
    for i=1:4
        if i==1
            theta(i)=150 + theta(i);
            angle(1)=(theta(i)*1024)/300;

        elseif i==2
            theta(i)=240 - theta(i) ;
            angle(2)=(theta(i)*1024)/300;
            angle(3)=1024-angle(2);
        elseif i==3
            theta(i)=180 - theta(i) ;
            angle(4)=(theta(i)*4096)/360;
        elseif i==4
            theta(i)=150 - theta(i);
            angle(5)=(theta(i)*1024)/300;
        end
    end
    
end