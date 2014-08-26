% function [] = feeder(~)
function [] = feeder(customer,fixpoint,divider,width,drop,details,panels,location,frame,note,copy,widthspec)

% clc;close all;clear all;
%inputs
%spec data
% individualwidthoriginal = [879 754 879];
% heightoriginal = 3333;
% louver = [13 14];
% aluminumtube=2212;
% TRBR=358;
% LVRS=286;
% DIVIDER=318;
% info data
% copy = 2;
% customer='Steve';fixpoint='F/F';divider=1;
% width=394;drop=2346;details='1opening';panels=1;
% location='12 address rd, clayton';frame=0;note='here is a note';

if frame==1
    heightoriginal = drop - 56;
    individualwidthoriginal = ones(1,panels) * (width-52-2*(panels+1))/panels;
else
    heightoriginal = drop - 4;
    individualwidthoriginal = ones(1,panels) * (width-2*(panels+1))/panels;
end

if mean(individualwidthoriginal)>104
    TRBR=mean(individualwidthoriginal)-32;
    LVRS=mean(individualwidthoriginal)-104;
    DIVIDER=mean(individualwidthoriginal)-72;
else
    TRBR=33;
    LVRS=105;
    DIVIDER=73;
end
    
aluminumtube=drop-2*2-120;
if ( ( isnan(divider)~=0 ) || divider~=0 ) && ( divider<(drop-4-115*2-85) ) && divider<=10   %there is a divider
    louvertotal = myround((drop-4-115*2-85)/75);
    louver = ones(1,divider+1);
    louver = louver * (louvertotal/(divider+1));
elseif ( ( isnan(divider)~=0 ) || divider~=0 ) && ( divider<(drop-4-115*2-85) ) && divider>10  %there is a special divider
    louvertotal = myround((drop-4-115*2-85)/75);
    louver = ones(1,2);
    louver(2) = myround((divider-2-115-85/2)/75);
    louver(1) = louvertotal - louver(2);
else
    louver = myround((drop-4-115*2)/75);
end

if isnan(widthspec)~=0
    if frame==1
        midwidth = (width-52-2*(panels+1)) - 2*widthspec;
        individualwidthoriginal = [widthspec midwidth widthspec];
    else
        midwidth = (width-2*(panels+1)) - 2*widthspec;
        individualwidthoriginal = [widthspec midwidth widthspec];
    end
end

vblind(individualwidthoriginal,heightoriginal,louver,copy,aluminumtube,TRBR,LVRS,DIVIDER,customer,fixpoint,divider,width,drop,details,panels,location,frame,note)
shading interp
set(gcf,'PaperPositionMode','auto')
set(gcf, 'PaperType', 'A4');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0.63 0.63 19.72 28.41]);


% print('-dpdf','-zbuffer','-r200')
% print('-v')

end