function [tt] = ikv3(coordinate)
%clear all

%fk;
%fkv2;
%h_fk2;

%%
l2 = 217;
l3 = 220;
l4 = 192;
phi=40* (pi/180.00);
x=coordinate(1);
y=coordinate(2);
z=coordinate(3);%334

%%

r2d = 180.00/pi;

t1 = atan2(y, x); 

xp = x - l4 * cos(phi) * cos (t1);
yp = y - l4 * cos(phi) * sin (t1);
zp = z - l4 * sin(phi);
r = sqrt(xp^2 + yp^2);
rp = sqrt(r^2 + zp^2);

alpha = atan(zp / r);
beta = acos((l2^2 + l3^2 - rp^2) / (2 * l2 * l3));
%gama = acos((rp^2 + l2^2 - l3^2) / 2* l2 * rp);
gama=acos((rp^2+l2^2-l3^2)/(2*rp*l2));
%gama = atan2(sqrt((2 * l2 * rp)^2 - (rp^2 + l2^2 - l3^2)^2), (rp^2 + l2^2 - l3^2));


%disp('gama r:');
%disp(gama * r2d);
t2 = alpha - gama;

t3 = pi - beta;
t3p = -t3;
t2p = t2 + 2 * gama;

t4 = phi - t2 - t3;
t4p = t3 + 2 * t2 - 2 * gama;

phi = phi * r2d;
theta1 = t1 * r2d;
theta2 = t2 * r2d;
theta3 = t3 * r2d;
theta4 = t4 * r2d;
theta2p = t2p * r2d;
theta3p = t3p * r2d;
theta4p = t4p * r2d;

tt=[theta1,theta2,theta3,theta4];
%{
disp('theta1:');
disp(theta1);
disp('theta2:');
disp(theta2);
disp('theta2p:');
disp(theta2p);
disp('theta3:');
disp(theta3);
disp('theta3p:');
disp(theta3p);
disp('theta4:');
disp(theta4);
disp('theta4p:');
disp(theta4p);
%}