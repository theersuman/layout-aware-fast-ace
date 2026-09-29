function [rect1, rect2] = bestSplitRectSimple(rect, areaExponent)

   Xa = floor((rect(1)+rect(3))/2);
   Ya = floor((rect(2)+rect(4))/2);
        
   rectHA = rect;
   rectHB = rect;
   rectVA = rect;
   rectVB = rect;
        
   rectHA(3) = Xa;
   rectHB(1) = Xa;
   rectVA(2) = Ya;
   rectVB(4) = Ya;
        
   rectHA(5) = rectangleError(rectHA, areaExponent);
   rectHB(5) = rectangleError(rectHB, areaExponent);
   rectVA(5) = rectangleError(rectVA, areaExponent);
   rectVB(5) = rectangleError(rectVB, areaExponent);
   
   errorH = rectHA(5) + rectHB(5); 
   errorV = rectVA(5) + rectVB(5);
   
   %errorO = rect(5);
   
%    if errorO < errorH
%        disp('Che stranoH, ')
%        disp(errorO)
%    end
%    
%    if errorO < errorV
%        disp('Che stranoV, ')
%        disp(errorO)
%    end
       
   
   if errorH < errorV
        rect1 = rectHA;
        rect2 = rectHB;
   else
        rect1 = rectVA;
        rect2 = rectVB;
    end
        

end