function avgDist = computeAvgDist(x0, y0, x1, y1)
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
            disp(x0);
            disp(y0);
            disp(x1);
            disp(y1);
            
        end
        
        distMin = sqrt(Xmin + Ymin);
        
        avgDist = (distMin+distMax)/2;

end

