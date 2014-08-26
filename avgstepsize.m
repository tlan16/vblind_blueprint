function [result] = avgstepsize(array)
    if length(array) == 1
        result = array(1);
    else
        result = array(2) - array(1);
        for i=1:length(array)-1
            result=(result+array(i+1)-array(i))/2;
        end
    end
end