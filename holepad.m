function [] = holepad(x,y,w,h)
% clc;close all;clear all;
% axis([190 190+688 254 254+1107.9]);set(gca,'DataAspectRatio',[1 1 1])
% x=190+688*0.45; y=254+1107.9*0.1; w=688*0.1; h=1107.9*0.8;
rectangle('position',[x,y,w,h]);

for i=1:8   %8 holes
    radius=w/4;
    cx=x+w/2;
    cy=y+(i/8)*h-radius*3;
    viscircles([cx cy],radius,'EdgeColor','k','LineWidth',1);
end

end