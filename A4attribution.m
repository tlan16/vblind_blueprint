%A4 paper attribution 297 x 210 in mm
axis on
axisymax = 2970; axisxmax = 2100;
axis ([0 axisxmax 0 axisymax]);

pritingmargint = [254 190]; %ver horri

x = pritingmargint(2);
y = pritingmargint(1);
w = axisxmax - 2*pritingmargint(2);
h = axisymax - 2*pritingmargint(1);
rectangle('position',[x,y,w,h],'LineStyle',':')
topinfratio=0.1;
topleftratio=0.6; bottemleftratio=0.4;
line([x x+w],[y+h*(1-topinfratio) y+h*(1-topinfratio)],'LineStyle',':','Color',[0 0 0]) %top info
line([x x+w],[y+h*(1-topinfratio)/2 y+h*(1-topinfratio)/2],'LineStyle',':','Color',[0 0 0]) %mid divider
line([x+w*topleftratio x+w*topleftratio],[y+h*(1-topinfratio)/2 y+h*(1-topinfratio)/2+h*(1-topinfratio)/2],'LineStyle',':','Color',[0 0 0]) %mid top
line([x+w*bottemleftratio x+w*bottemleftratio],[y y+h*(1-topinfratio)/2],'LineStyle',':','Color',[0 0 0]) %mid bottem
