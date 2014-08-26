function [num] = yestoone(string)

if ( (strcmp(lower(string),'yes')==1) || (strcmp(lower(string),'tes')==1) || (strcmp(lower(string),'1')==1) )
    num=1;
else
    num=0;
end

end