function [theta] = LSE(EE,Desired)

    %T=[R,t];
    %{
    [c,~]=size(EE);
    EE=EE(:,:,:)*100;
    EEE=[];
    for i=1:c
        EEE=[EEE;EE(i,1,1),EE(i,1,2),EE(i,1,3),1];
    end
    A=EEE
    %}
    A=EE(:,:)*100;
    [c,~]=size(A);
    A=[A,ones(c,1)];
    Desired=Desired(:,:)/10;
    
    I=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
   
    theta1=inv(A'*A + 0.3*I)*A'*Desired(1:end,1);
    theta2=inv(A'*A + 0.3*I)*A'*Desired(1:end,2);
    theta3=inv(A'*A + 0.3*I)*A'*Desired(1:end,3);
    
    theta=[theta1';theta2';theta3']
    
    %{
    [r,~]=size(A);
    e=0;
    e=Desired-(A*T');
    e=e.*e;
    e=sum(e,2);
    e=sqrt(e);
    e=sum(e)/r
   %}
   [r,~]=size(A);
    e=0;
    e=Desired-(A*theta');
    e=e.*e;
    e=sum(e,2);
    e=sqrt(e);
    e=sum(e)/r
    
    %a=A*T';
    %b=A*theta';
    %Desired;
    %A(1,1:end)*theta'
    %Desired(1,1:end)
end