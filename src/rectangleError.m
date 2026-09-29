function Error = rectangleError(rect, areaExponent)
% areaExponent = 0.5 --> estimate average error
% areaExponent = 1.0 --> estimate max error
% intermediate values are also possible 

    x0 = rect(1);
    y0 = rect(2);
    x1 = rect(3)-1;
    y1 = rect(4)-1;
    
    if (x0 > x1) %Casi di rettangolo degenere
        Error = 10000;
    elseif (y0 > y1)
        Error = 10000;
    else
        
        Xmax = max(x0^2, x1^2);
        Ymax = max(y0^2, y1^2);
        Xmin = min(x0^2, x1^2);
        Ymin = min(y0^2, y1^2);
        
        distMax = sqrt(Xmax + Ymax);
        
        
        if (x0*x1) < 0
            Xmin = 0;
        end
        
        if (y0*y1) < 0
            Ymin = 0;
        end
        
        if (and(Xmin ==  0, Ymin ==  0))
            disp('Rectangle cannot include (0,0)');
            disp(rect);
        end
        
        distMin = sqrt(Xmin + Ymin);
        
        distMed = (distMin+distMax)/2;
        
        ErrorPerPixel1 = (distMax - distMed)/(distMax * distMed);
        ErrorPerPixel2 = (distMed - distMin)/(distMin * distMed);
        
        
        area = (x1+1 - x0)*(y1 - y0+1);
              
        Error = max([ErrorPerPixel1, ErrorPerPixel2]*(area^areaExponent)); 
       
    end

end