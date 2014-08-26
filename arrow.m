% clc;close all;clear all;
% A4attribution;

function [] = arrow(x1,y1,x2,y2)

a=scribe.doublearrow('Parent',gca,'X',[x1 x2],'Y',[y1 y2],'HeadStyle','plain','HeadWidth',5000,'HeadLength',5000);

end