%%
%clc
%clear all
%close all
%%
function [x,y,z]=fkv2(an)
d2r = pi/180.00;

theta1 =an(1);
theta2 =an(2);
theta3 = an(3);
theta4 = an(4);


phi = theta2 + theta3 + theta4;

phi = phi * d2r;

t1 = theta1 * d2r;
t2 = theta2 * d2r;
t3 = theta3 * d2r;
t4 = theta4 * d2r;

l2 = 217;
l3 = 220;
l4 = 192;

A1 = [cos(t1) 0 sin(t1) 0
     sin(t1) 0 -cos(t1) 0
     0 1 0 0
     0 0 0 1];
 
A2 = [cos(t2) -sin(t2) 0 l2*cos(t2)
     sin(t2) cos(t2) 0 l2*sin(t2)
     0 0 1 0
     0 0 0 1];
 
A3 = [cos(t3) -sin(t3) 0 l3*cos(t3)
     sin(t3) cos(t3) 0 l3*sin(t3)
     0 0 1 0
     0 0 0 1];
 
A4 = [cos(t4) -sin(t4) 0 l4*cos(t4)
     sin(t4) cos(t4) 0 l4*sin(t4)
     0 0 1 0
     0 0 0 1];
 

t = A1*A2*A3*A4;

x = t(1,4);
y = t(2,4);
z = t(3,4);
%{
disp('x:');
disp(x);
disp('y:');
disp(y);
disp('z:');
disp(z);
%}