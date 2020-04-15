function [theta] = RLSE(data,landa)
    
    
    EE=data(1:end,1:3);
    desired=data(1:end,4:6);
    A=EE(:,:)*100;
    [c,~]=size(A);
    A=[A,ones(c,1)];
    desired=desired(:,:)/10;
    [r,~]=size(A);
    w=[];
    for i=1:r
        w(i,i)=landa^(r-i);
    end
    I=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
    theta1=inv(A'*w*A + 0.3*I)*A'*w*desired(1:end,1);
    theta2=inv(A'*w*A + 0.3*I)*A'*w*desired(1:end,2);
    theta3=inv(A'*w*A + 0.3*I)*A'*w*desired(1:end,3);
    theta=[theta1';theta2';theta3'];
    
    [r,~]=size(A);
    e=0;
    e=desired-(A*theta');
    e=e.*e;
    e=sum(e,2);
    e=sqrt(e);
    AVGDist=sum(e)/r
    
    b=A*theta';
end