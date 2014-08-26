function [result] = myround(num)

if (num-floor(num))>0.3
    result=floor(num)+1;
else
    result=floor(num);
end

end