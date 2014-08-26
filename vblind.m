%Vblind
function [] = vblind(individualwidthoriginal,heightoriginal,louver,copy,aluminumtube,TRBR,LVRS,DIVIDER,customer,fixpoint,divider,width,drop,details,panels,location,frame,note)
% clc; close all; clear all;

% %inputs
% %spec data
% individualwidthoriginal = [879, 754, 879];
% heightoriginal = 3333;
% louver = [3,7,8];
% copy = 2;
% aluminumtube=2212;
% TRBR=358;
% LVRS=286;
% DIVIDER=318;
% %info data
% customer='Steve';fixpoint='F/F';divider=1;
% width=394;drop=2346;details='1opening';panels=1;
% location='12 address rd, clayton';frame=0;note='here is a note';

A4attribution;
%% ------------------top left(frame) section-------------------------------
regionxlocation=190; regionylocation=1361.9;
regionxmax=1032; regionymax=1107.9;
%paddings
leftpadding = regionxmax*0.1; bottompadding = regionymax*0.1; cellpadding = regionxmax*0.01;  

individualwidth = regionxmax/ (sum(individualwidthoriginal)+(length(individualwidthoriginal)+1) * cellpadding) * individualwidthoriginal * 0.8;
height = regionymax/heightoriginal * heightoriginal * 0.8;
framexlocations = ones(1,length(individualwidth));
frameylocations = ones(1,length(individualwidth));
for i = 1:length(individualwidth);
    if i == 1;
        %draw inner individual frames
        x = regionxlocation+leftpadding;
        y = regionylocation+bottompadding;
        w = individualwidth(1);
        h = height;
        rectangle('position',[x,y,w,h])
        %get overall inner frame drawing left root coordinate
        currentx = x-cellpadding;
        currenty = y-cellpadding;
        %get overall inner frame height and width
        innermaxx = sum(individualwidth)+(length(individualwidth)+1) * cellpadding;
        innermaxy = h+2*cellpadding;
        %draw inner overall frame
        rectangle('position',[currentx,currenty,innermaxx,innermaxy]);
        %get all the inner individual frame left root coordinates
        framexlocations(i) = x;
        frameylocations(i) = y;
        %calculate available top space to draw spec annotation
        topspace = regionylocation + regionymax - (currenty + innermaxy);
        %draw spec annotation
        arrow(framexlocations(i),currenty+innermaxy+topspace/4,framexlocations(i)+individualwidth(i),currenty+innermaxy+topspace/4);
        %   individual width
        text(framexlocations(i)+individualwidth(i)/2,currenty+innermaxy+topspace*3/6,num2str(individualwidthoriginal(i)),'HorizontalAlignment','Center','VerticalAlignment','Middle');
        %   left spec annotation
        leftspace = currentx - regionxlocation;
        arrow(currentx-leftspace/4,currenty,currentx-leftspace/4,currenty+height);
        text(currentx-leftspace*3/8,currenty+height/2,num2str(heightoriginal),'HorizontalAlignment','Right','VerticalAlignment','Middle');
        %draw div
        if length(louver)==2
            divpositiony=louver(2)/sum(louver)*height + frameylocations(1);
            rectangle('position',[framexlocations(i),divpositiony-cellpadding*1.5,individualwidth(i),cellpadding*3],'FaceColor',[0.8 0.8 0.8]);
        else
            divpositiony = ones(1,length(louver)-1);
            for j=1:length(louver)-1;
               divpositiony(j) = j/(length(louver)) * height + frameylocations(i);
               rectangle('position',[framexlocations(i),divpositiony(j)-cellpadding*1.5,individualwidth(i),cellpadding*3],'FaceColor',[0.8 0.8 0.8]);
            end
        end
        %draw louver spec
        if length(louver)==1
            text(framexlocations(1)+individualwidth(1)/2,frameylocations(1)+0.5*height,strcat(num2str(louver(1)),' LVRS'),'HorizontalAlignment','Center','VerticalAlignment','Middle');
        end
        for j=1:length(louver)-1
            if length(louver)== 2;
                text(framexlocations(i)+individualwidth(i)/2,frameylocations(i)+height*3/4,strcat(num2str(louver(1)),' LVRS'),'HorizontalAlignment','Center','VerticalAlignment','Middle');
                text(framexlocations(i)+individualwidth(i)/2,frameylocations(i)+height*1/4,strcat(num2str(louver(2)),' LVRS'),'HorizontalAlignment','Center','VerticalAlignment','Middle');
            else
                louverinv=fliplr(louver);
                text(framexlocations(i)+individualwidth(i)/2,divpositiony(j)-0.5*avgstepsize(divpositiony),strcat(num2str(louverinv(j)),' LVRS'),'HorizontalAlignment','Center','VerticalAlignment','Middle');
                text(framexlocations(i)+individualwidth(i)/2,divpositiony(j)+0.5*avgstepsize(divpositiony),strcat(num2str(louverinv(j+1)),' LVRS'),'HorizontalAlignment','Center','VerticalAlignment','Middle');
            end
        end
    else
        %draw inner individual frames
        x = x + w + cellpadding;
        y = y;
        w = individualwidth(i);
        h = height;
        rectangle('position',[x,y,w,h])
        %get all the inner individual frame left root coordinates
        framexlocations(i) = x;
        frameylocations(i) = y;
        %draw spec annotation
        arrow(framexlocations(i),currenty+innermaxy+topspace/4,framexlocations(i)+individualwidth(i),currenty+innermaxy+topspace/4);
        text(framexlocations(i)+individualwidth(i)/2,currenty+innermaxy+topspace*3/6,num2str(individualwidthoriginal(i)),'HorizontalAlignment','Center','VerticalAlignment','Middle');
        %draw div
        if length(louver)==2
            divpositiony=louver(2)/sum(louver)*height + frameylocations(1);
            rectangle('position',[framexlocations(i),divpositiony-cellpadding*1.5,individualwidth(i),cellpadding*3],'FaceColor',[0.8 0.8 0.8]);
        else
            divpositiony = ones(1,length(louver)-1);
            for j=1:length(louver)-1;
               divpositiony(j) = j/(length(louver)) * height + frameylocations(i);
               rectangle('position',[framexlocations(i),divpositiony(j)-cellpadding*1.5,individualwidth(i),cellpadding*3],'FaceColor',[0.8 0.8 0.8]);
            end
        end
    end
end
%notice of copy
if copy ~= 1
    text(regionxlocation+regionxmax,regionylocation+regionymax*0.8,strcat({'X '},num2str(copy)),'HorizontalAlignment','Center','VerticalAlignment','Middle','FontWeight','Bold','FontSize',15);
end
%--------------end of left(frame) section-------------------------------%
%% top right(Stile A\B) section
%side bar
regionxlocation=1222; regionylocation=1361.9;
regionxmax=688; regionymax=1107.9;
leftpadding = regionxmax/2*0.1; bottompadding = regionymax*0.1; cellpadding = regionxmax*0.01;  %paddings
%local inputs
    noofsideA=(length(individualwidth)+1)*copy;
    noofsideB=(length(individualwidth)-1)*copy;
    sideAlength=heightoriginal; sideBlength=heightoriginal;
if noofsideB
    rectangle('position',[regionxlocation+regionxmax/2*0.7,regionylocation+bottompadding,regionxmax/2*0.1,regionymax*0.7]);
    rectangle('position',[regionxlocation+regionxmax*(0.5+0.5*0.55),regionylocation+bottompadding,regionxmax/2*0.1,regionymax*0.7]);
    arrow(regionxlocation+regionxmax/2*0.55,regionylocation+bottompadding,regionxlocation+regionxmax/2*0.55,regionylocation+regionymax*0.8);
    arrow(regionxlocation+regionxmax*(0.5+0.5*0.45),regionylocation+bottompadding,regionxlocation+regionxmax*(0.5+0.5*0.45),regionylocation+regionymax*0.8);
    text(regionxlocation+regionxmax/2*0.5,regionylocation+regionymax*0.45,num2str(sideAlength),'HorizontalAlignment','Right','VerticalAlignment','Middle');
    text(regionxlocation+regionxmax*(0.5+0.5*0.4),regionylocation+regionymax*0.45,num2str(sideBlength),'HorizontalAlignment','Right','VerticalAlignment','Middle');
    text(regionxlocation+regionxmax/2*0.35,regionylocation+regionymax*0.9,strcat('Stile A x',{' '},num2str(noofsideA)),'HorizontalAlignment','Left','VerticalAlignment','Middle');
    text(regionxlocation+regionxmax*(0.5+0.5*0.2),regionylocation+regionymax*0.9,strcat('Stile B x',{' '},num2str(noofsideB)),'HorizontalAlignment','Left','VerticalAlignment','Middle');
else
    rectangle('position',[regionxlocation+regionxmax*0.7,regionylocation+bottompadding,regionxmax/2*0.1,regionymax*0.7]);
    arrow(regionxlocation+regionxmax*0.65,regionylocation+bottompadding,regionxlocation+regionxmax*0.65,regionylocation+regionymax*0.8);
    text(regionxlocation+regionxmax*0.6,regionylocation+regionymax*0.45,num2str(sideAlength),'HorizontalAlignment','Right','VerticalAlignment','Middle');
    text(regionxlocation+regionxmax*0.54,regionylocation+regionymax*0.9,strcat('Stile A x',{' '},num2str(noofsideA)),'HorizontalAlignment','Left','VerticalAlignment','Middle');
end
%--------------end of top right section-----------------
%bottom left(hold pads etc.) section
regionxlocation=190; regionylocation=254;
regionxmax=688; regionymax=1107.9;
leftpadding = regionxmax/2*0.1; bottompadding = regionymax*0.1; cellpadding = regionxmax*0.01;  %paddings
%left part
holepad(regionxlocation+regionxmax*0.2,regionylocation,regionxmax*0.1,regionymax*0.8);
arrow(regionxlocation+regionxmax*0.15,regionylocation,regionxlocation+regionxmax*0.15,regionylocation+regionymax*0.8);
for i=1:length(louver)
    padlocationx=regionxlocation+regionxmax*0.1;
    padlocationy=regionylocation+regionymax*0.8*(i/length(louver))-regionymax*0.8/length(louver)/2;
    padwidth=regionxmax*0.3;
    padhight=regionymax*0.8*0.1;
    rectangle('position',[padlocationx,padlocationy,padwidth,padhight],'FaceColor','w');
    louverinv=fliplr(louver);
    text(padlocationx+padwidth*0.5,padlocationy+padhight*0.5,strcat(num2str(louverinv(i)),{'holes x '},num2str(length(individualwidth)*copy)),'HorizontalAlignment','Center','VerticalAlignment','Middle');
end
%right part
rectangle('position',[regionxlocation+regionxmax*(0.5+0.2+0.05/2),regionylocation,regionxmax*(0.1-0.05),regionymax*0.8]);
rectangle('position',[regionxlocation+regionxmax*(0.5+0.25/2),regionylocation+regionymax*0.5,regionxmax*0.25,regionymax*0.8*0.1],'FaceColor','w');
text(regionxlocation+regionxmax*(0.5+0.25),regionylocation+regionymax*(0.5+0.8*0.1*0.5),num2str(aluminumtube),'HorizontalAlignment','Center','VerticalAlignment','Middle');
%top part
text(regionxlocation+regionxmax*0.25,regionylocation+regionymax*0.9,strcat({'C/R x '},num2str(length(louver)*length(individualwidth)*copy)),'HorizontalAlignment','Center','VerticalAlignment','Middle');
text(regionxlocation+regionxmax*0.75,regionylocation+regionymax*0.9,strcat({'A/T x '},num2str(length(individualwidth)*copy)),'HorizontalAlignment','Center','VerticalAlignment','Middle');
%--------------end of bottom left section--------------------------
%bottem right(TR\BR\LVRS\DIVS) section
regionxlocation=878; regionylocation=254;
regionxmax=1032; regionymax=1107.9;
levelhight=regionymax/3;levelwidth=regionxmax*0.6;
%TR&BR
TRBRrescaled=levelwidth*3*(TRBR/(TRBR+LVRS+DIVIDER));
rectangle('position',[regionxlocation+regionxmax*0.5-TRBRrescaled*0.5,regionylocation+levelhight*2,TRBRrescaled,levelhight*0.5]);
arrow(regionxlocation+regionxmax*0.5-TRBRrescaled*0.5,regionylocation+levelhight*2.55,regionxlocation+regionxmax*0.5+TRBRrescaled*0.5,regionylocation+levelhight*2.55);
text(regionxlocation+regionxmax*0.5,regionylocation+levelhight*(2+0.5*0.5),strcat({'TR&BR x '},num2str(panels*2*copy)),'HorizontalAlignment','Center','VerticalAlignment','Middle');
text(regionxlocation+regionxmax*0.5,regionylocation+levelhight*2.55,num2str(TRBR),'HorizontalAlignment','Center','VerticalAlignment','Bottom');
%LVRS
LVRSRrescaled=levelwidth*3*(LVRS/(TRBR+LVRS+DIVIDER));
rectangle('position',[regionxlocation+regionxmax*0.5-LVRSRrescaled*0.5,regionylocation+levelhight*1,LVRSRrescaled,levelhight*0.5]);
arrow(regionxlocation+regionxmax*0.5-LVRSRrescaled*0.5,regionylocation+levelhight*1.55,regionxlocation+regionxmax*0.5+LVRSRrescaled*0.5,regionylocation+levelhight*1.55);
text(regionxlocation+regionxmax*0.5,regionylocation+levelhight*(1+0.5*0.5),strcat({'LVRS x '},num2str(sum(louver)*panels*copy)),'HorizontalAlignment','Center','VerticalAlignment','Middle');
text(regionxlocation+regionxmax*0.5,regionylocation+levelhight*1.55,num2str(LVRS),'HorizontalAlignment','Center','VerticalAlignment','Bottom');
%DIVIDER
if length(louver)~=1
DIVIDERRrescaled=levelwidth*3*(DIVIDER/(TRBR+LVRS+DIVIDER));
rectangle('position',[regionxlocation+regionxmax*0.5-DIVIDERRrescaled*0.5,regionylocation+levelhight*0,DIVIDERRrescaled,levelhight*0.5]);
arrow(regionxlocation+regionxmax*0.5-DIVIDERRrescaled*0.5,regionylocation+levelhight*0.55,regionxlocation+regionxmax*0.5+DIVIDERRrescaled*0.5,regionylocation+levelhight*0.55);
text(regionxlocation+regionxmax*0.5,regionylocation+levelhight*(0+0.5*0.5),strcat({'DIVIDER x '},num2str((length(louver)-1)*panels*copy)),'HorizontalAlignment','Center','VerticalAlignment','Middle');
text(regionxlocation+regionxmax*0.5,regionylocation+levelhight*0.55,num2str(DIVIDER),'HorizontalAlignment','Center','VerticalAlignment','Bottom');
end
%----------------end of bottom right section--------------------------
%top info section
regionxlocation=190; regionylocation=2469.8;
regionxmax=1032+688; regionymax=246.2;
xlocations=[regionxlocation regionxlocation+regionxmax/3 regionxlocation+regionxmax*2/3]*1.1;
ylocations=[regionylocation+regionymax regionylocation+regionymax*2/3 regionylocation+regionymax*1/3]*0.99;
text(xlocations(1),ylocations(1),strcat({'Customer: '},customer),'HorizontalAlignment','Left','VerticalAlignment','Middle');
text(xlocations(2),ylocations(1),strcat({'Fix Point: '},fixpoint),'HorizontalAlignment','Left','VerticalAlignment','Middle');
text(xlocations(3),ylocations(1),strcat({'Divider: '},onetoyes(divider)),'HorizontalAlignment','Left','VerticalAlignment','Middle');
text(xlocations(1),ylocations(2),strcat({'Width x drop:'},strcat(num2str(width),{' x '},num2str(drop))),'HorizontalAlignment','Left','VerticalAlignment','Middle');
text(xlocations(2),ylocations(2),strcat({'Details: '},details),'HorizontalAlignment','Left','VerticalAlignment','Middle');
text(xlocations(3),ylocations(2),strcat({'Panels: '},num2str(panels)),'HorizontalAlignment','Left','VerticalAlignment','Middle');
text(xlocations(1),ylocations(3),strcat({'Addr: '},location),'HorizontalAlignment','Left','VerticalAlignment','Middle');
text(xlocations(2)+90,ylocations(3),strcat({'Frame: '},onetoyes(frame)),'HorizontalAlignment','Left','VerticalAlignment','Middle');
text(xlocations(3),ylocations(3),strcat({'Note: '},note),'HorizontalAlignment','Left','VerticalAlignment','Middle');
%-----------------end of top info section---------------------

axis off
set(gca,'position',[0 0 1 1],'units','normalized')
set(gca,'xcolor','w','ycolor','w','xtick',[],'ytick',[]);
set(gcf,'color','w');
set(gca,'box','off');
set(gca,'DataAspectRatio',[1 1 1]);

pause(0.00001);
frame_h = get(handle(gcf),'JavaFrame');
set(frame_h,'Maximized',1);

end